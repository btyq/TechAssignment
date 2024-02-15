#main.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region = var.region
}

#--------All defined modules-------

module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id        = module.networking.vpc_id
  subnet_ids    = module.networking.subnet_ids
  security_group_id = module.networking.security_group_id
}


