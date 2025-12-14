#infra/modules/vpc/variables.tf
variable "vpc_name" {
    default = "eks-vpc"
}

variable "cluster_name" {
    default = "eks-cluster"
}

variable "region" {
    type = string
    default = "ap-southeast-2"
    description = "AWS Region"
}

variable "cidr_block" {
    type = string 
    default = "10.0.0.0/16"
}

variable "tags" {
    type = map(string)
    default = {
      terraform = "true"
      kubernetes = "eks-cluster"
    }
    description = "Tags for all resources"
}

