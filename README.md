# Terraform EC2 Practice

A learning project for practicing Terraform: provisioning an EC2 instance
running Ubuntu 26.04 in the AWS free tier, with controlled (pinned) AMI
updates and basic network configuration (Security Group for SSH/HTTP).

## What gets created

- **EC2 instance** (`t3.small`, Ubuntu 26.04 LTS, x86_64) with nginx installed
  via `user_data`.
- **Security Group** — allows SSH only from a specified IP and HTTP from
  anywhere.

## Prerequisites

- Terraform >= 1.9.0
- AWS CLI configured via `aws configure`
- An AWS account with EC2 access
- An existing EC2 Key Pair (see below on how to create one)

## Setup before first run

### 1. Create a Key Pair (if you don't have one yet)

```bash
aws ec2 create-key-pair \
  --key-name tf-practice-key \
  --region eu-central-1 \
  --query 'KeyMaterial' \
  --output text > tf-practice-key.pem

chmod 400 tf-practice-key.pem