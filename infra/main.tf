module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source          = "./eks"
  private_subnets = module.vpc.private_subnet_ids  # <--- mapping happens here
  cluster_role_arn  = module.iam.cluster_role_arn
  node_role_arn     = module.iam.node_role_arn
}



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}
