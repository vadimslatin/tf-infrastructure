output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.practice_ec2.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.practice_ec2.public_ip
}

output "ssh_connection_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i <path-to-your-key>.pem ubuntu@${aws_instance.practice_ec2.public_ip}"
}

output "pinned_ami_id" {
  description = "AMI ID currently pinned in var.ami_id"
  value       = var.ami_id
}

output "latest_available_ami_id" {
  description = "Latest matching AMI available from Canonical (for comparison — update var.ami_id manually if outdated)"
  value       = data.aws_ami.ubuntu.id
}

output "ami_is_outdated" {
  description = "True if a newer AMI is available than the one currently pinned"
  value       = var.ami_id != data.aws_ami.ubuntu.id
}
