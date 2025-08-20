variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "us-east-1"
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type = string
  default = "my-ec2-project"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type = string
  default = "ami-09e6f87a47903347c" # Amazon Linux 2 AMI (update based on region)
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}
variable "key_pair_name" {
  description = "Name of the AWS key pair for EC2 instance"
  type        = string
}
