# infra/main.tf - Complete orchestration
# 1. VPC - Foundation
module "vpc" {
  source = "./modules/vpc"
  
  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block
  tags       = var.tags
}

# 2. EKS - Depends on VPC
module "eks" {
  source = "./modules/eks"
  
  cluster_name     = var.cluster_name
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  public_subnets   = module.vpc.public_subnets
  tags             = var.tags
  depends_on = [module.vpc]
}

module "argocd" {
  source = "./modules/argocd"
  depends_on = [    module.eks]
}

module "monitoring" {
  source = "./modules/monitoring"

  depends_on = [ module.argocd]
}

