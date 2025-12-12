#infra/eks.tf

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.10.0"

  name               = var.cluster_name
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id 

  create_iam_role = true 
  attach_encryption_policy = false 
  
  endpoint_private_access = true 
  endpoint_public_access = true 

  control_plane_subnet_ids = concat(module.vpc.private_subnets, module.vpc.public_subnets)

  create_security_group = true 
  security_group_description = "EKS security Group"

  authentication_mode = "API"
  enable_cluster_creator_admin_permissions = true 

  dataplane_wait_duration = "40s"

  #default overrides 
  create_cloudwatch_log_group = false 
  create_kms_key = false 
  enable_kms_key_rotation = false 
  kms_key_enable_default_policy = false 
  enable_irsa = false 
  encryption_config = null
  enable_auto_mode_custom_tags = false 

  #EKS managed node groups 
  create_node_security_group = true
  node_security_group_enable_recommended_rules = true
  node_security_group_description = "Security groups used by nodes to communicate with cluster"

  node_security_group_use_name_prefix = true 


  subnet_ids = module.vpc.private_subnets
  eks_managed_node_groups = {
    group1 = {
        name = "node-group-1"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
    group2 = {
      name           = "node-group-2"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }

  fargate_profiles = {
    profile1 = {
        selectors = [
            {
                namespace = "kube-system"
            }
        ]
    }
  }

  tags = var.tags
}