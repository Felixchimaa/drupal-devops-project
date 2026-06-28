########################################
# Get Latest Ubuntu 22.04 AMI
########################################

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

########################################
# EC2 Instance 1
########################################

resource "aws_instance" "drupal_server_1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.drupal_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Drupal-Server-1"
  }
}

########################################
# EC2 Instance 2
########################################

resource "aws_instance" "drupal_server_2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_2.id
  vpc_security_group_ids      = [aws_security_group.drupal_sg.id]
  key_name                    = "Goodness"
  associate_public_ip_address = true

  tags = {
    Name = "Drupal-Server-2"
  }
}
