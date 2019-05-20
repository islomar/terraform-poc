variable "name" {
  type = "string"
  description = "User name"
}

variable "teams" {
  type = "list"
  description = "A list of usernames responsible for approving code reviews in this repo"
  default = []
}