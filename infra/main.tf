#/main.tf

module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source          = "./eks"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  # cluster_role_arn = module.iam.cluster_role_arn
  # node_role_arn    = module.iam.node_role_arn
  cluster_name     = "monitoring_cluster"
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



# Add to root main.tf or outputs.tf
output "debug_info" {
  value = {
    vpc_id          = module.vpc.vpc_id
    public_subnets  = module.vpc.public_subnets
    subnet_count    = length(module.vpc.public_subnets)
    cluster_role    = module.iam.cluster_role_arn
    node_role       = module.iam.node_role_arn
  }
}