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
    tags = {
      Name = "terraform-practice-root"
    }

  }

  user_data = templatefile("${path.module}/templates/user_data.sh.tpl", {
    project_name = var.project_name
  })

  tags = {
    Name    = "${var.project_name}-instance"
    Project = var.project_name
  }
}

# Add additional storage
# lsblk
# sudo mkfs.ext4 /dev/nvme1n1
# sudo mkdir -p /backup
# sudo mount /dev/nvme1n1 /backup
# df -h /backup
# sudo blkid /dev/nvme1n1
# echo 'UUID=295f1c67-349f-4769-9380-2c397a8306be /backup ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab
# sudo mount -a

# resource "aws_ebs_volume" "backup" {
#   availability_zone = aws_instance.practice_ec2.availability_zone
#   size              = 2
#   type              = "gp3"
#   encrypted         = true

#   tags = {
#     Name    = "terraform-practice-backup"
#     Project = "terraform-practice"
#   }
# }

# resource "aws_volume_attachment" "backup_attach" {
#   device_name = "/dev/sdf"
#   volume_id   = aws_ebs_volume.backup.id
#   instance_id = aws_instance.practice_ec2.id
# }
