resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.SUBNET_CIDR
  map_public_ip_on_launch = true
  tags = {
    Name = "Main"
  }
}


output "SUBNET" {
  value = aws_subnet.main.id
}
