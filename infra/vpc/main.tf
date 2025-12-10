
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.6.1"

  cidr = var.vpc_cidr
  name = var.vpc_name

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnets, 0, 3)
  public_subnets  = slice(var.public_subnets, 0, 3)

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Environment = "Dev"
    Project     = "Prometheus-Grafana"
  }
}


data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}


