# Create PagerDuty users
resource "pagerduty_user" "${var.name}" {
  name      = "${var.name}"
  email     = "islomar+pagerduty-user1@gmail.com"
  time_zone = "Europe/London"
  teams     = "${var.teams}"
}

resource "pagerduty_user_contact_method" "phone_user1" {
  user_id      = "pagerduty_user.${var.name}.id"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "620666452"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms_user1" {
  user_id      = "pagerduty_user.${var.name}.id"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}
