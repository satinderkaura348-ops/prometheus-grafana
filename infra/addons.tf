# # Install CoreDNS addon
# resource "aws_eks_addon" "coredns" {
#   cluster_name      = module.eks.cluster_name
#   addon_name        = "coredns"
#   addon_version     = "v1.11.1-eksbuild.4"
#   resolve_conflicts_on_create =   "OVERWRITE"
  
#   depends_on = [module.eks]
# }

# # Install kube-proxy addon
# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name      = module.eks.cluster_name
#   addon_name        = "kube-proxy"
#   addon_version     = "v1.30.0-eksbuild.2"
#   resolve_conflicts_on_create = "OVERWRITE"
  
#   depends_on = [module.eks]
# }

# # Install vpc-cni addon
# resource "aws_eks_addon" "vpc_cni" {
#   cluster_name      = module.eks.cluster_name
#   addon_name        = "vpc-cni"
#   addon_version     = "v1.17.0-eksbuild.1"
#   resolve_conflicts_on_create = "OVERWRITE"
  
#   depends_on = [module.eks]
# }