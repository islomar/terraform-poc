variable "name" {
  type        = "string"
  description = "User name"
}

variable "email" {
  type = "string"
}

variable "country_code" {
  type        = "string"
  description = "Country code to be used both for the phone and the SMS"
}

variable "phone_number" {
  type        = "string"
  description = "Number to be used both for the phone and the SMS"
}

variable "phone_label" {
  type    = "string"
  default = "Mobile"
}

variable "sms_label" {
  type    = "string"
  default = "Mobile"
}

variable "role" {
  type    = "string"
  default = "user"
}

variable "teams" {
  type        = "list"
  description = "A list of usernames responsible for approving code reviews in this repo"
  default     = []
}
