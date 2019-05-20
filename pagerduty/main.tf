terraform {
  backend "remote" {
    organization = "islomar"

    workspaces {
      name = "infrastructure-pagerduty"
    }
  }
}

# Configure the PagerDuty provider
provider "pagerduty" {
  token = "${var.pagerduty_token}"
}

# Create a PagerDuty team
resource "pagerduty_team" "engineering" {
  name        = "Engineering"
  description = "All engineering"
}
