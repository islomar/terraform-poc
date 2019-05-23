resource "pagerduty_escalation_policy" "example" {
  name      = "Engineering Escalation Policy"
  num_loops = 9
  teams     = ["${pagerduty_team.engineering.id}"]

  rule {
    escalation_delay_in_minutes = 4

    target {
      type = "schedule_reference"
      id   = "${pagerduty_schedule.on_call_schedule.id}"
    }
  }

  rule {
    escalation_delay_in_minutes = 3

    target {
      type = "user_reference"
      id   = "${module.user2.user_id}"
    }
  }
}
