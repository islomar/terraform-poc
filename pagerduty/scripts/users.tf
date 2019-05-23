resource "pagerduty_user" "islomar+pagerduty-batman" {
  name      = "Batman"
  email     = "islomar+pagerduty-batman@gmail.com"
  role      = "user"
  time_zone = "Europe/London"
  job_title = "Developer"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-batman_email" {
  user_id      = "PB10LNU"
  type         = "email_contact_method"
  address      = "islomar+pagerduty-batman@gmail.com"
  label        = "Default"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-batman_phone_contact_method" {
  user_id      = "PB10LNU"
  type         = "phone_contact_method"
  country_code = "34"
  address      = "111222333"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-batman_sms_contact_method" {
  user_id      = "PB10LNU"
  type         = "sms_contact_method"
  country_code = "34"
  address      = "666555444"
  label        = "Home"
}

resource "pagerduty_user" "islomar" {
  name      = "Isidro Lopez"
  email     = "islomar@gmail.com"
  role      = "owner"
  time_zone = "Europe/Madrid"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "islomar_email" {
  user_id      = "P5OX0C6"
  type         = "email_contact_method"
  address      = "islomar@gmail.com"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "islomar_phone_contact_method" {
  user_id      = "P5OX0C6"
  type         = "phone_contact_method"
  country_code = "1"
  address      = "620666452"
  label        = "Other"
}

resource "pagerduty_user_contact_method" "islomar_phone_contact_method" {
  user_id      = "P5OX0C6"
  type         = "phone_contact_method"
  country_code = "1"
  address      = "3332221110"
  label        = "Other"
}

resource "pagerduty_user" "peter-nguyen" {
  name      = "Peter Nguyen"
  email     = "peter.nguyen@form3.tech"
  role      = "admin"
  time_zone = "Europe/Madrid"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "peter-nguyen_email" {
  user_id      = "PJJ49TJ"
  type         = "email_contact_method"
  address      = "peter.nguyen@form3.tech"
  label        = "Default"
}

resource "pagerduty_user" "islomar+pagerduty-user1" {
  name      = "User 1"
  email     = "islomar+pagerduty-user1@gmail.com"
  role      = "user"
  time_zone = "Europe/London"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user1_email" {
  user_id      = "P6GPTDW"
  type         = "email_contact_method"
  address      = "islomar+pagerduty-user1@gmail.com"
  label        = "Default"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user1_phone_contact_method" {
  user_id      = "P6GPTDW"
  type         = "phone_contact_method"
  country_code = "34"
  address      = "666555444"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user1_sms_contact_method" {
  user_id      = "P6GPTDW"
  type         = "sms_contact_method"
  country_code = "34"
  address      = "666555444"
  label        = "Mobile"
}

resource "pagerduty_user" "islomar+pagerduty-user2" {
  name      = "User 2bb"
  email     = "islomar+pagerduty-user2@gmail.com"
  role      = "user"
  time_zone = "Europe/London"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user2_email" {
  user_id      = "PHKL6QS"
  type         = "email_contact_method"
  address      = "islomar+pagerduty-user2a@gmail.com"
  label        = "Default"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user2_phone_contact_method" {
  user_id      = "PHKL6QS"
  type         = "phone_contact_method"
  country_code = "34"
  address      = "444555666"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user2_sms_contact_method" {
  user_id      = "PHKL6QS"
  type         = "sms_contact_method"
  country_code = "34"
  address      = "444555666"
  label        = "Mobile"
}

resource "pagerduty_user" "islomar+pagerduty-user3" {
  name      = "User 3cc"
  email     = "islomar+pagerduty-user3@gmail.com"
  role      = "user"
  time_zone = "Europe/London"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user3_email" {
  user_id      = "PPXHE9Z"
  type         = "email_contact_method"
  address      = "islomar+pagerduty-user3@gmail.com"
  label        = "Default"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user3_phone_contact_method" {
  user_id      = "PPXHE9Z"
  type         = "phone_contact_method"
  country_code = "34"
  address      = "444555666"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user3_sms_contact_method" {
  user_id      = "PPXHE9Z"
  type         = "sms_contact_method"
  country_code = "34"
  address      = "444555666"
  label        = "Mobile"
}

resource "pagerduty_user" "islomar+pagerduty-user4" {
  name      = "User 4"
  email     = "islomar+pagerduty-user4@gmail.com"
  role      = "user"
  time_zone = "Europe/London"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user4_email" {
  user_id      = "P01J5U2"
  type         = "email_contact_method"
  address      = "islomar+pagerduty-user4@gmail.com"
  label        = "Default"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user4_phone_contact_method" {
  user_id      = "P01J5U2"
  type         = "phone_contact_method"
  country_code = "34"
  address      = "111222333"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user4_sms_contact_method" {
  user_id      = "P01J5U2"
  type         = "sms_contact_method"
  country_code = "34"
  address      = "111222333"
  label        = "Work"
}

resource "pagerduty_user" "islomar+pagerduty-user5" {
  name      = "User 5"
  email     = "islomar+pagerduty-user5@gmail.com"
  role      = "user"
  time_zone = "Europe/London"
  job_title = "None"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user5_email" {
  user_id      = "P3B766S"
  type         = "email_contact_method"
  address      = "islomar+pagerduty-user5@gmail.com"
  label        = "Default"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user5_phone_contact_method" {
  user_id      = "P3B766S"
  type         = "phone_contact_method"
  country_code = "34"
  address      = "111222333"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "islomar+pagerduty-user5_sms_contact_method" {
  user_id      = "P3B766S"
  type         = "sms_contact_method"
  country_code = "34"
  address      = "111222333"
  label        = "Mobile"
}

