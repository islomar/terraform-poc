resource "pagerduty_user" "global-admin" {
  name      = "Global admin"
  email     = "islomar+pagerduty-admin@gmail.com"
  time_zone = "Europe/London"
  role      = "admin"
  teams     = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "phone_global-admin" {
  user_id      = "${pagerduty_user.global-admin.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "620666452"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms_global-admin" {
  user_id      = "${pagerduty_user.global-admin.id}"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}

module "user1" {
  source    = "modules/users"
  name      = "User 1"
  email     = "islomar+pagerduty-user1@gmail.com"
  country_code = "+34"
  phone_number = "666555444"
  teams     = ["${pagerduty_team.engineering.id}"]
}

module "user2" {
  source    = "modules/users"
  name      = "User 2"
  email     = "islomar+pagerduty-user2@gmail.com"
  country_code = "+34"
  phone_number = "444555666"
  teams     = ["${pagerduty_team.engineering.id}"]
}
