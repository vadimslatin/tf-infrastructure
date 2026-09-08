resource "aws_security_group" "practice_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH and HTTP for practice instance"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

resource "aws_instance" "practice_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.practice_sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = <<-EOT
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "Hello from Terraform practice instance" > /var/www/html/index.html
              EOT

  tags = {
    Name    = "${var.project_name}-instance"
    Project = var.project_name
  }
}
