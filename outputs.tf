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
  value       = "ssh -i <path-to-your-key>.pem ec2-user@${aws_instance.practice_ec2.public_ip}"
}