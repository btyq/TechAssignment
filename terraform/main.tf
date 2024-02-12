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
  profile = "TechnicalAssignment"
  region = "us-east-1"
}

#obtaining cidr_info from supposedly an api call from python script
data "external" "cidr_info" {
  program = ["python", "${path.root}/../scripts/cidr_info.py"] 

}

#creating of VPC
resource "aws_vpc" "main" {
  cidr_block = "${data.external.cidr_info.result.ip_address}${data.external.cidr_info.result.subnet_size}"
}

#creating subnet /24 out of /16
resource "aws_subnet" "public" {
  count = 256 #total number of /24 subnets in a /16
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("${data.external.cidr_info.result.ip_address}${data.external.cidr_info.result.subnet_size}", 8, count.index)
  availability_zone = "us-east-1a"
}

