variable "private_subnets" {
  description = "List of private subnet IDs for EKS cluster"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS node group"
  type        = string
}

variable "region" {
  default = "ap-southeast-2"
}

variable "cluster_name" {
  default = "monitoring_cluster"
  }

  variable "subnet_ids" {
  description = "Private subnets IDs for EKS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EKS"
  type        = string
}
