# Configure the PagerDuty provider
provider "pagerduty" {
  token = "${var.pagerduty_token}"
}

# Create a PagerDuty team
resource "pagerduty_team" "engineering" {
  name        = "Engineering"
  description = "All engineering"
}

# Create a PagerDuty user
resource "pagerduty_user" "earline" {
  name  = "Earline Greenholt"
  email = "gato_lopez76@yahoo.es"
  teams = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "phone" {
  user_id      = "${pagerduty_user.earline.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "620666452"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms" {
  user_id      = "${pagerduty_user.earline.id}"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}
