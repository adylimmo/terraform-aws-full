terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

data "terraform_remote_state" "security_groups" {
  backend = "local"
  
  config = {
    path = var.state_path
  }
}

# Retrieve subnet IDs
data "terraform_remote_state" "subnets" {
  backend = "local"

  config = {
    path = var.state_path
  }
}

resource "aws_instance" "ec2_anakdevops_cicd" {
  count                  = 1
  ami                    = "ami-0497a974f8d5dcef8"
  instance_type          = "t2.micro"
  key_name               = data.terraform_remote_state.security_groups.outputs.key_pair_id
  vpc_security_group_ids = [data.terraform_remote_state.security_groups.outputs.security_group_id]
  subnet_id              = data.terraform_remote_state.subnets.outputs.subnet_id
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  tags = {
    Name = "database_private_dev-${count.index}"
  }
}
