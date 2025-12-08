resource "aws_eks_cluster" "cluster" {
  name = "monitoring_cluster"

  role_arn = var.cluster_role_arn
  version  = "1.31"

  vpc_config {
    subnet_ids = var.private_subnets

  }


}


resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "monitoring_node_group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets


  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

   instance_types = ["t3.medium"]

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.


  tags = {
  Environment = "Dev"
  Project     = "Prometheus-Grafana"
}

}