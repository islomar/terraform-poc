provider "aws" {
  region  = "eu-west-1"
  version = "~> 3.11.0"
}

resource "aws_s3_bucket" "first_bucket" {
  bucket = "islomar-first-bucket"
}
