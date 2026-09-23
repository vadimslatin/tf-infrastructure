terraform {
  required_version = "~> 1.9.0"

  backend "s3" {
    bucket         = "tf-practice-state-398934907074"
    key            = "s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-practice-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.64"
    }
  }
}
