# -*- coding: utf-8 -*-
import argparse
import requests
import json
import subprocess
from collections import Counter

# TODO: add more propoerties, e.g. teams
TF_USER_TEMPLATE = '''resource "pagerduty_user" "%s" {
  name      = "%s"
  email     = "%s"
  role      = "%s"
  time_zone = "%s"
  job_title = "%s"
}

'''

TF_USER_CONTACT_METHOD_DEFAULT_TEMPLATE = '''resource "pagerduty_user_contact_method" "%s" {
  user_id      = "%s"
  type         = "%s"
  country_code = "%s"
  address      = "%s"
  label        = "%s"
}

'''

TF_USER_CONTACT_METHOD_EMAIL_TEMPLATE = '''resource "pagerduty_user_contact_method" "%s_email" {
  user_id      = "%s"
  type         = "%s"
  address      = "%s"
  label        = "%s"
}

'''


def _parse_pagerduty_token_arg():
    parser = argparse.ArgumentParser()
    parser.add_argument('--pagerduty_token', '-pt', help="PagerDuty token",
                        type=str, required=True)
    args = parser.parse_args()
    return args.pagerduty_token


def _generate_terraform_files_with_http_api(pagerduty_token):
    print 'Querying all users...'
    response = _get_pagerduty_uri('https://api.pagerduty.com/users', pagerduty_token)
    all_users = response.json()['users']
    print 'Number of users fetched: {}'.format(len(all_users))
    all_generated_users = ''
    print 'Generating all users...'
    for raw_user in all_users:
        user = json.loads(json.dumps(raw_user))
        user_resource_name = _extract_resource_name_from_email(user['email'])
        generated_user = _extract_user(user, user_resource_name)
        all_generated_users += generated_user
        contact_methods = _extract_contact_methods(user, pagerduty_token, user_resource_name)
        all_generated_users += contact_methods
    _generate_terraform_file(all_generated_users)
    return _generate_user_id_to_resource_name_map(all_users)


def _generate_user_id_to_resource_name_map(all_users):
    user_id_to_resource_name_map = {}
    for raw_user in all_users:
        user = json.loads(json.dumps(raw_user))
        user_id = user['id']
        user_resource_name = _extract_resource_name_from_email(user['email'])
        user_id_to_resource_name_map[user_id] = user_resource_name
    return user_id_to_resource_name_map


def _import_terraform_resources(pagerduty_token, user_id_to_resource_name_map):
    for user_id, resource_name in user_id_to_resource_name_map.items():
        tf_import_commands = ["terraform",
                              "import",
                              "-var",
                              "'pagerduty_token={}'".format(pagerduty_token),
                              "pagerduty_user.{}".format(resource_name),
                              "{}".format(user_id)]
        subprocess.call(tf_import_commands)


def _extract_user(user, user_resource_name):
    # Required parameters
    name = user['name']
    email = user['email']
    # Optional parameters
    role = user['role']
    time_zone = user['time_zone']
    job_title = user['job_title']
    return TF_USER_TEMPLATE % (user_resource_name, name, email, role, time_zone, job_title)


def _extract_contact_methods(user, pagerduty_token, user_resource_name):
    contact_methods = user['contact_methods']
    all_contact_methods_configuration = ''
    ## TODO: control number of resources of same type to change its name
    Counter()
    user_id = user['id']
    print 'Retrieving the contact methods for user_id {}'.format(user_id)
    for contact_method in contact_methods:
        contact_method_uri = contact_method['self']
        contact_method_response = _get_pagerduty_uri(contact_method_uri, pagerduty_token)
        raw_full_contact_method = contact_method_response.json()['contact_method']
        full_contact_method = json.loads(json.dumps(raw_full_contact_method))
        if 'email' in full_contact_method['type']:
            generated_tf_contact_method = _generate_email_contact_method(user_id,
                                                                         full_contact_method,
                                                                         user_resource_name)
        else:
            generated_tf_contact_method = _generate_default_contact_method(user_id,
                                                                           full_contact_method,
                                                                           user_resource_name)
        all_contact_methods_configuration += generated_tf_contact_method
    return all_contact_methods_configuration


def _generate_email_contact_method(user_id, full_contact_method, user_resource_name):
    type = full_contact_method['type']
    address = full_contact_method['address']
    label = full_contact_method['label']
    return TF_USER_CONTACT_METHOD_EMAIL_TEMPLATE % (user_resource_name,
                                                    user_id,
                                                    type,
                                                    address,
                                                    label)


def _generate_default_contact_method(user_id, full_contact_method, user_resource_name):
    type = full_contact_method['type']
    address = full_contact_method['address']
    label = full_contact_method['label']
    country_code = full_contact_method['country_code']
    return TF_USER_CONTACT_METHOD_DEFAULT_TEMPLATE % ('{}_{}'.format(user_resource_name, type),
                                                      user_id,
                                                      type,
                                                      country_code,
                                                      address,
                                                      label)


def _generate_terraform_file(all_generated_users):
    print 'Creating users.tf...'
    with open('users.tf', 'w') as f:
        f.write(all_generated_users)


def _get_pagerduty_uri(uri, pagerduty_token):
    return requests.get(uri,
                        headers={'Accept': 'application/vnd.pagerduty+json;version=2',
                                 'Authorization': 'Token token={}'.format(pagerduty_token)})


def _extract_resource_name_from_email(email):
    return email.split("@")[0].replace('.', '-')


if __name__ == '__main__':
    pagerduty_token = _parse_pagerduty_token_arg()
    user_id_to_resource_name_map = _generate_terraform_files_with_http_api(pagerduty_token)
    _import_terraform_resources(pagerduty_token, user_id_to_resource_name_map)
