#eks/main.tf

data "aws_caller_identity" "current" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "22.0.0"

  name    = var.cluster_name
  kubernetes_version = "1.33"
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  # Disable custom KMS key creation
  create_kms_key = false

  # THIS IS THE KEY FIX FOR v21+
  enable_cluster_encryption_config = false   # ← disables the entire block
  cluster_encryption_config        = []      # ← must be empty list when disabled

  # Disable CloudWatch log group creation
  create_cloudwatch_log_group = false

  # Node groups
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

  tags = {
    Environment = "Dev"
    Project     = "Prometheus-Grafana"
  }
}


