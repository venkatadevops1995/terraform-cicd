# Provider configuration
provider "aws" {
  region = var.aws_region
  # Remove hardcoded credentials - use AWS credentials file or environment variables instead
}

# Variables
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-south-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0a4408457f9a03be3"
}

variable "instance_name_prefix" {
  description = "Prefix for instance names"
  type        = string
  default     = "myinstance"
}

# EC2 Instances
resource "aws_instance" "instance1" {
  count                       = var.instance_count
  instance_type               = var.instance_type
  ami                         = var.ami_id
  associate_public_ip_address = true

  tags = {
    Name        = "${var.instance_name_prefix}-${count.index + 1}"
    Environment = "development"
    ManagedBy   = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Outputs
output "instance_ids" {
  description = "IDs of created EC2 instances"
  value       = aws_instance.instance[*].id
}

output "instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.instance[*].public_ip
}

output "instance_private_ips" {
  description = "Private IP addresses of EC2 instances"
  value       = aws_instance.instance[*].private_ip
}
