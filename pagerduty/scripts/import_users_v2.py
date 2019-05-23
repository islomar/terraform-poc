# -*- coding: utf-8 -*-
# PoC trying the PagerDuty Python library: it doesn't seem to be seriously updated?
# https://github.com/PagerDuty/pagerduty-api-python-client

import argparse
import pypd

def _parse_pagerduty_token_arg():
    parser = argparse.ArgumentParser()
    parser.add_argument('--pagerduty_token', '-pt', help="PagerDuty token",
                        type=str, required=True)
    args = parser.parse_args()
    return args.pagerduty_token


if __name__ == '__main__':
    pagerduty_token = _parse_pagerduty_token_arg()
    pypd.api_key = pagerduty_token
    users = pypd.User.find()
    print users
    emails = [u.email for u in users]
    for email in emails:
        u = pypd.User.find_one(email=email)
        print(u.email, email)