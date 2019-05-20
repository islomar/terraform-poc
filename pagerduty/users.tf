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

resource "pagerduty_user" "user1" {
  name      = "User 1"
  email     = "islomar+pagerduty-user1@gmail.com"
  time_zone = "Europe/London"
  teams     = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "phone_user1" {
  user_id      = "${pagerduty_user.user1.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "620666452"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms_user1" {
  user_id      = "${pagerduty_user.user1.id}"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}

resource "pagerduty_user" "user2" {
  name      = "User 2"
  email     = "islomar+pagerduty-user2@gmail.com"
  time_zone = "Europe/London"
  teams     = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "phone_user2" {
  user_id      = "${pagerduty_user.user2.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "620666452"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms_user2" {
  user_id      = "${pagerduty_user.user2.id}"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}

