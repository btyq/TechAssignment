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
}

module "load_balancer" {
  source = "./modules/load_balancer"
}


