#main.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
    }
  }
  
  backend "remote" {
        # The name of your Terraform Cloud organization.
        organization = "TechnicalAssignment"

        # The name of the Terraform Cloud workspace to store Terraform state files in.
        workspaces {
            name = "terraform-github-actions"
        }
  }
}

provider "aws" {
  access_key = "${AWS_ACCESS_KEY_ID}"
  secret_key = "${AWS_SECRET_ACCESS_KEY}"
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

  depends_on = [ module.networking ]
}


