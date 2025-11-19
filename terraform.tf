provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAUDRNICT5W7OMRENH"
  secret_key = "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"
}

resource "aws_instance" "instance" {
  instance_type = "t3.micro"
  ami = "ami-0a4408457f9a03be3"
  count = 2
  associate_public_ip_address = true
  tags = {
    Name = "myinstance"
  }
}

