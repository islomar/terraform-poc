variable "name" {
  type = "string"
  description = "User name"
}

variable "email" {
  type = "string"
}

variable "phone_number" {
  type = "string"
  description = "Number to be used both for the phone and the SMS"
}

variable "country_code" {
  type = "string"
  description = "Country code to be used both for the phone and the SMS"
}

variable "teams" {
  type = "list"
  description = "A list of usernames responsible for approving code reviews in this repo"
  default = []
}