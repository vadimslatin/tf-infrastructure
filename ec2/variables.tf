variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type (must stay free-tier eligible)"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "Explicit AMI ID for the EC2 instance. Update deliberately via PR after verifying new AMI (see data.tf for lookup helper)."
  type        = string
}

variable "key_pair_name" {
  description = "Name of the existing AWS key pair for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the instance (e.g. your IP as x.x.x.x/32)"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
  default     = "terraform-practice"
}