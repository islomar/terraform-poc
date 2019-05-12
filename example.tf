provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}

# Assign an Elastic IP to the EC2 instance
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}
