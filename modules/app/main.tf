terraform {
  required_version = ">= 0.12"
}

locals {
  alb_port = 80
  alb_protocol = "HTTP"
}

data "aws_ami" "app" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  owners = [
    "099720109477"
  ]
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "this" {
  key_name = "${var.project_name}-key-pair"
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name = "${var.project_name}-key-pair"
    Owner = var.owner
    Project = var.project_name
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.app.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.this.key_name

  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "${var.project_name}-app"
    Owner = var.owner
    Project = var.project_name
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  vpc = true

  tags = {
    Name = "${var.project_name}-app-eip"
    Owner = var.owner
    Project = var.project_name
  }
}
