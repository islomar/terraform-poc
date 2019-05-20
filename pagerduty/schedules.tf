resource "pagerduty_schedule" "on_call_schedule" {
  name      = "Production: on-call engineer"
  time_zone = "Europe/London"

  layer {
    name                         = "On call schedule"
    start                        = "2018-05-22T12:00:00-08:00"
    rotation_virtual_start       = "2018-05-22T12:00:00-08:00"
    rotation_turn_length_seconds = 604800                                                       //7 days
    users                        = ["${pagerduty_user.user1.id}", "${pagerduty_user.user2.id}"]
  }
}