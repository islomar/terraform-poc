# PagerDuty

* We need to configure a `PAGERDUTY_TOKEN`
* `terraform apply -var 'pagerduty_token=<your_token>'`
* To import a user resource: `terraform import -var 'pagerduty_token=<your_token>' pagerduty_user.<resource_name> <resource_id>`
* To apply only the users: `terraform apply -target=pagerduty_users` 