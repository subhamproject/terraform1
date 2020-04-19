
locals {
  tag_prefix = "Main_${data.aws_caller_identity.myidentity.account_id}_${data.aws_region.myregion.name}"
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.SUBNET_CIDR
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.tag_prefix}_subnet"
  }
}


output "SUBNET" {
  value = aws_subnet.main.id
}
