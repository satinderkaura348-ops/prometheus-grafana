#eks/main.tf

data "aws_caller_identity" "current" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.10.1"

  name    = var.cluster_name
  kubernetes_version = "1.33"
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  create_iam_role = false
  iam_role_arn    = var.cluster_role_arn
  
  endpoint_public_access  = true
  # Disable custom KMS key creation
  create_kms_key = false

  # THIS IS THE KEY FIX FOR v21+
  
  encryption_config  = null     # ← must be empty list when disabled

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


