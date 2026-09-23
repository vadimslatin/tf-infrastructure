variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "S3 bucket name for practice files (must be globally unique)"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
  default     = "terraform-practice"
}

variable "object_expiration_days" {
  description = "Number of days after which objects (and noncurrent versions) are deleted"
  type        = number
  default     = 10
}
