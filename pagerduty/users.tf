module "global-admin" {
  source       = "modules/users"
  name         = "Global admin"
  email        = "islomar+pagerduty-global-admin@gmail.com"
  role         = "admin"
  country_code = "+34"
  phone_number = "222333444"
  teams        = ["${pagerduty_team.engineering.id}"]
}

module "user1" {
  source       = "modules/users"
  name         = "User 1"
  email        = "islomar+pagerduty-user1@gmail.com"
  country_code = "+34"
  phone_number = "666555444"
  teams        = ["${pagerduty_team.engineering.id}"]
}

module "user2" {
  source       = "modules/users"
  name         = "User 2bb"
  email        = "islomar+pagerduty-user2@gmail.com"
  country_code = "+34"
  phone_number = "444555666"
  teams        = ["${pagerduty_team.engineering.id}"]
}

module "isidro_lopez" {
  source       = "modules/users"
  name         = "User 3cc"
  email        = "islomar+pagerduty-user3@gmail.com"
  country_code = "+34"
  phone_number = "444555666"
  teams        = ["${pagerduty_team.engineering.id}"]
}