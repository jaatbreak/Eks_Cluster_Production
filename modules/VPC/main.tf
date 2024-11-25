
# VPC
resource "aws_vpc" "production_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "production-vpc"
  }
}

# Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.production_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_a
  tags = {
    Name = "production-public-subnet"
  }
}

 # Two prvate subnet 

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags = {
    Name = "production-private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags = {
    Name = "production-private-subnet-b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name = "production-internet-gateway"
  }
}


# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name = "production-public-route-table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


# NAT Gateway
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "production-nat-eip"
  }
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "production-nat-gateway"
  }
}

# Private Route Table for Subnet A
resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name = "production-private-route-table-a"
  }
}

resource "aws_route" "private_route_a" {
  route_table_id         = aws_route_table.private_rt_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}


resource "aws_route_table_association" "private_assoc_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

# Private Route Table for Subnet B
resource "aws_route_table" "private_rt_b" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name = "production-private-route-table-b"
  }
}


resource "aws_route" "private_route_b" {
  route_table_id         = aws_route_table.private_rt_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_assoc_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt_b.id
}