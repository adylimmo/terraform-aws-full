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


data "terraform_remote_state" "development" {
  backend = "local"
  config = {
    path = "../../development/vpc/terraform.tfstate" # Path ke state file development
  }
}


data "terraform_remote_state" "staging" {
  backend = "local"
  config = {
    path = "../../staging/vpc/terraform.tfstate" # Path ke state file Staging
  }
}


resource "aws_vpc_peering_connection" "development_to_staging" {
  vpc_id      = data.terraform_remote_state.development.outputs.vpc_id
  peer_vpc_id = data.terraform_remote_state.staging.outputs.vpc_id
  auto_accept = true

  tags = {
    Name = "development-to-Staging-Peering"
  }
}


resource "aws_route" "dev_to_staging_private" {
  route_table_id         = data.terraform_remote_state.development.outputs.private_route_table_id
  destination_cidr_block = data.terraform_remote_state.staging.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.development_to_staging.id
}


resource "aws_route" "staging_to_dev_private" {
  route_table_id         = data.terraform_remote_state.staging.outputs.private_route_table_id
  destination_cidr_block = data.terraform_remote_state.development.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.development_to_staging.id
}

resource "aws_route" "dev_to_staging_public" {
  route_table_id         = data.terraform_remote_state.development.outputs.public_route_table_id
  destination_cidr_block = data.terraform_remote_state.staging.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.development_to_staging.id
}


resource "aws_route" "staging_to_dev_public" {
  route_table_id         = data.terraform_remote_state.staging.outputs.public_route_table_id
  destination_cidr_block = data.terraform_remote_state.development.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.development_to_staging.id
}
