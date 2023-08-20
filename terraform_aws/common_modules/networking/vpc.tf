resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.subnet_configs

  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public ? true : false


  tags = {
    "Name" = each.key
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.vpc_name}-ig"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_block_rtb_public
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    "Name" = "${var.vpc_name}-public-rtb"
  }
}

resource "aws_route_table_association" "association" {
  for_each       = { for k, v in var.subnet_configs : k => v }
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = each.value.public ? aws_route_table.public.id : aws_route_table.private.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  depends_on = [aws_internet_gateway.ig]

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnets["public_subnet_01"].id

  tags = {
    "Name" = "${var.vpc_name}-nat-gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_block_rtb_private
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    "Name" = "${var.vpc_name}-private-rtb"
  }
}

resource "aws_security_group" "sg" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.sg_configs
  name     = each.key

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.key
  }
}