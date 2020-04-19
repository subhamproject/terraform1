resource "aws_vpc" "main" {
  cidr_block       = var.VPCCIDR
  instance_tenancy = var.TENANCY
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false
  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.r.id
}

output "VPC" {
  value = aws_vpc.main.id
}
