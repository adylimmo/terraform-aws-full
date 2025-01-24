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


data "terraform_remote_state" "staging" {
  backend = "local"
  config = {
    path = "../../staging/vpc/terraform.tfstate" # Path ke state file staging
  }
}


data "terraform_remote_state" "production" {
  backend = "local"
  config = {
    path = "../../production/vpc/terraform.tfstate" # Path ke state file production
  }
}


resource "aws_vpc_peering_connection" "staging_to_production" {
  vpc_id      = data.terraform_remote_state.staging.outputs.vpc_id
  peer_vpc_id = data.terraform_remote_state.production.outputs.vpc_id
  auto_accept = true

  tags = {
    Name = "staging-to-production-Peering"
  }
}


resource "aws_route" "stag_to_production_private" {
  route_table_id         = data.terraform_remote_state.staging.outputs.private_route_table_id
  destination_cidr_block = data.terraform_remote_state.production.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_production.id
}


resource "aws_route" "production_to_stag_private" {
  route_table_id         = data.terraform_remote_state.production.outputs.private_route_table_id
  destination_cidr_block = data.terraform_remote_state.staging.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_production.id
}

resource "aws_route" "stag_to_production_public" {
  route_table_id         = data.terraform_remote_state.staging.outputs.public_route_table_id
  destination_cidr_block = data.terraform_remote_state.production.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_production.id
}


resource "aws_route" "production_to_stag_public" {
  route_table_id         = data.terraform_remote_state.production.outputs.public_route_table_id
  destination_cidr_block = data.terraform_remote_state.staging.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_production.id
}
