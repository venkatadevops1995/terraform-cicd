provider "aws" {
  region = "ap-south-1"
}

# EC2 Instances
resource "aws_instance" "instance1" {
  count                       = 2
  instance_type              = "t3.micro"
  ami                        = "ami-0a4408457f9a03be3"
  associate_public_ip_address = true

  tags = {
    Name        = "myinstance-${count.index + 1}"
    Environment = "development"
    ManagedBy   = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}
