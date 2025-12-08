

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  tags = {
    Name = each.key
    }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  
  tags = {
    Name = each.key
    }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.route_table}-public"
  }
}


resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id 
}

resource "aws_eip" "monitoring_eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "monitoring_nat_gw" {
  allocation_id = aws_eip.monitoring_eip.id 
  subnet_id     = aws_subnet.public["monitoring-public-1"].id
  tags = {
    Name = "gw_NAT"
  }

  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.monitoring_eip
    ]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.monitoring_nat_gw.id 
  }

  tags = {
    Name = "${var.route_table}-private"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id 
}
