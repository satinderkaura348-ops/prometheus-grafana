#vpc/main.tf

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  cidr = var.vpc_cidr
  name = var.vpc_name

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnets, 0, 3)
  public_subnets  = slice(var.public_subnets, 0, 3)

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  map_public_ip_on_launch = true 

  tags = {
    Environment = "Dev"
    Project     = "Prometheus-Grafana"
  }

   # Separate tags for different resource types
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
}



data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}


