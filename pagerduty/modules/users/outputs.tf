output "user_ids" {
  value = "${join(",", pagerduty_user.*.id)}"
}