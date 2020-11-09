
terraform {
  backend "s3" {
    bucket = "islomar-terraform-state"
    key    = "myproject.state"
    region = "eu-west-1"
  }
}
