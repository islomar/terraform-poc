# Create PagerDuty users
resource "pagerduty_user" "main" {
  name      = "${var.name}"
  email     = "${var.email}"
  time_zone = "Europe/London"
  role     = "${var.role}"
  teams     = ["${var.teams}"]
}

resource "pagerduty_user_contact_method" "phone_contact" {
  user_id      = "${pagerduty_user.main.id}"
  type         = "phone_contact_method"
  country_code = "${var.country_code}"
  address      = "${var.phone_number}"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms_contact" {
  user_id      = "${pagerduty_user.main.id}"
  type         = "sms_contact_method"
  country_code = "${var.country_code}"
  address      = "${var.phone_number}"
  label        = "Work"
}
