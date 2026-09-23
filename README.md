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

- Terraform
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
```

## Terraform Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.64 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.practice_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.practice_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ssh_cidr"></a> [allowed\_ssh\_cidr](#input\_allowed\_ssh\_cidr) | CIDR block allowed to SSH into the instance (e.g. your IP as x.x.x.x/32) | `string` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | Explicit AMI ID for the EC2 instance. Update deliberately via PR after verifying new AMI (see data.tf for lookup helper). | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for resources | `string` | `"eu-central-1"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type (must stay free-tier eligible) | `string` | `"t3.small"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name of the existing AWS key pair for SSH access | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name used for tagging resources | `string` | `"terraform-practice"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_is_outdated"></a> [ami\_is\_outdated](#output\_ami\_is\_outdated) | True if a newer AMI is available than the one currently pinned |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the created EC2 instance |
| <a name="output_latest_available_ami_id"></a> [latest\_available\_ami\_id](#output\_latest\_available\_ami\_id) | Latest matching AMI available from Canonical (for comparison — update var.ami\_id manually if outdated) |
| <a name="output_pinned_ami_id"></a> [pinned\_ami\_id](#output\_pinned\_ami\_id) | AMI ID currently pinned in var.ami\_id |
| <a name="output_public_url"></a> [public\_url](#output\_public\_url) | Public URL |
| <a name="output_ssh_connection_command"></a> [ssh\_connection\_command](#output\_ssh\_connection\_command) | Command to SSH into the instance |
<!-- END_TF_DOCS -->
