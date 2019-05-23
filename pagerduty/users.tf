module "global-admin" {
  source       = "modules/users"
  name         = "Global admin"
  email        = "islomar+pagerduty-global-admin@gmail.com"
  role         = "admin"
  country_code = "+34"
  phone_number = "222333444"
  teams        = ["${pagerduty_team.engineering.id}"]
}

module "user1" {
  source       = "modules/users"
  name         = "User 1"
  email        = "islomar+pagerduty-user1@gmail.com"
  country_code = "+34"
  phone_number = "666555444"
  teams        = ["${pagerduty_team.engineering.id}"]
}

module "user2" {
  source       = "modules/users"
  name         = "User 2bb"
  email        = "islomar+pagerduty-user2@gmail.com"
  country_code = "+34"
  phone_number = "444555666"
  teams        = ["${pagerduty_team.engineering.id}"]
}

module "isidro_lopez" {
  source       = "modules/users"
  name         = "User 3cc"
  email        = "islomar+pagerduty-user3@gmail.com"
  country_code = "+34"
  phone_number = "444555666"
  teams        = ["${pagerduty_team.engineering.id}"]
}

// module.john_smith.pagerduty_user

//module "john_smith" {
//  source       = "modules/users"
//  email        = "islomar+pagerduty-johnsmith@gmail.com"
//  name         = "John Smith"
//  country_code = "+34"
//  phone_number = "444555666"
//  teams        = ["${pagerduty_team.engineering.id}"]
//}

//module "john_smith" {
//  source = "modules/users"
//  name = ""
//  email = ""
//  country_code = ""
//  phone_number = ""
//}

resource "pagerduty_user" "user4" {
  name      = "User 4"
  time_zone = "Europe/London"
  role      = "user"
  email     = "islomar+pagerduty-user4@gmail.com"
  teams     = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "user4_phone" {
  user_id      = "${pagerduty_user.user4.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "111222333"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "user4_sms" {
  user_id      = "${pagerduty_user.user4.id}"
  type         = "sms_contact_method"
  country_code = "+34"
  address      = "111222333"
  label        = "Work"
}

resource "pagerduty_user" "user5" {
  name      = "User 5"
  email     = "islomar+pagerduty-user5@gmail.com"
  time_zone = "Europe/London"
  role      = "user"
  teams     = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "user5_phone" {
  user_id      = "${pagerduty_user.user5.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "111222333"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "user5_sms" {
  user_id      = "${pagerduty_user.user5.id}"
  type         = "sms_contact_method"
  country_code = "+34"
  address      = "111222333"
  label        = "Mobile"
}