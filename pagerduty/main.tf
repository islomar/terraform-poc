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
resource "pagerduty_user" "batman" {
  name  = "Mr. Batman"
  email = "gato_lopez76@yahoo.es"
  time_zone = "Europe/London"
  teams = ["${pagerduty_team.engineering.id}"]
}

resource "pagerduty_user_contact_method" "phone" {
  user_id      = "${pagerduty_user.batman.id}"
  type         = "phone_contact_method"
  country_code = "+34"
  address      = "620666452"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms" {
  user_id      = "${pagerduty_user.batman.id}"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}

resource "pagerduty_schedule" "on_call_schedule" {
  name      = "On call schedule"
  time_zone = "Europe/London"

  layer {
    name                         = "On call schedule"
    start                        = "2018-05-22T12:00:00-08:00"
    rotation_virtual_start       = "2018-05-22T12:00:00-08:00"
    rotation_turn_length_seconds = 604800 //7 days
    users                        = ["${pagerduty_user.batman.id}"]
  }
}