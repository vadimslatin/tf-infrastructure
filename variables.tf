variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type (must stay free-tier eligible)"
  type        = string
  default     = "t2.micro" # или t3.micro, зависит от региона
}

variable "key_pair_name" {
  description = "Name of the existing AWS key pair for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the instance"
  type        = string
  default     = "0.0.0.0/0" # ⚠️ для практики ок, в реальности - ограничить своим IP
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
  default     = "terraform-practice"
}