variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "CIDR block for the VPC"
}

variable "vpc_name" {
    default = "monitoring-vpc"
    description = "Name for VPC"
}

variable "igw_name" {
    default = "monitoring-igw"
    description = "Name for igw"
}

variable "route_table" {
    default = "monitoring-route-table"
    description = "Name for route table"
}

variable "public_subnets" {
    description = "Map of public subnet names to CIDR"
    default = {
        "monitoring-public-1" = "10.0.1.0/24"
        "monitoring-public-2" = "10.0.2.0/24"
        "monitoring-public-3" = "10.0.3.0/24"
    }
}

variable "private_subnets" {
    description = "Map of private subnet names to CIDR"
    default = {
        "monitoring-private-1" = "10.0.4.0/24"
        "monitoring-private-2" = "10.0.5.0/24"
        "monitoring-private-3" = "10.0.6.0/24"
    }
}