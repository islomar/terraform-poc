provider "aws" {
#  region     = "us-east-1"
#  access_key = "${var.access_key}"
#  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# New resource for the S3 bucket our application will use.
/*
 resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "islomar-terraform-getting-started-guide"
  acl    = "private"
}
*/

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "echo 'Destroy-time provisioner'"
  }

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
#  depends_on = ["aws_s3_bucket.example"]
}

//# WARNING: No Free-tier!!!
/*
module "consul" {
  source = "hashicorp/consul/aws"

  num_servers = "3"
}
*/

/*
resource "aws_instance" "another" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}+*/

# Assign an Elastic IP to the EC2 instance
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

terraform {
  backend "consul" {
    address = "demo.consul.io"
    path    = "getting-started-islomar"
    lock    = false
  }
}

output "ami" {
  value = "${lookup(var.amis, var.region)}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}