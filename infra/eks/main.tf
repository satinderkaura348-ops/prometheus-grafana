#eks/main.tf


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "21.10.1"  
  name    = var.cluster_name
  kubernetes_version = "1.33"
  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id
  
  tags = {
    Environment = "Dev"
    Project     = "Prometheus-Grafana"
}

  # Node Groups
  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
    two = {
      name           = "node-group-2"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }


  }
}


