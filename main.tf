//terraform {
//  backend "s3" {
//    region = "eu-west-3"
//    bucket = "s3-terraform-interview"
//    key = "melalex/terraform-recruit/cluster.tfstate"
//  }
//}

provider "aws" {
  version = "~> 3.0"
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  project_name = "terraform-runner"
  owner = "melalex"
}

data "aws_availability_zones" "this" {}

module "app" {
  source = "./modules/app"

  owner = local.owner
  project_name = local.project_name
}

module "ansible" {
  source = "./modules/ansible"

  app_eip_list = [
    module.app.this_eip_public_ip
  ]

  app_ssh_private_key_pem = module.app.this_ssh_private_key_pem
  app_ssh_public_key_pem = module.app.this_ssh_public_key_pem
}
