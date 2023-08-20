output "subnets" {
  value = aws_subnet.subnets
}

output "private_subnets_id" {
  value = [
    aws_subnet.subnets["private_subnet_01"].id,
    aws_subnet.subnets["private_subnet_02"].id
  ]
}

output "public_subnets_id" {
  value = [
    aws_subnet.subnets["public_subnet_01"].id,
    aws_subnet.subnets["public_subnet_02"].id
  ]
}

output "sg_private" {
  value = aws_security_group.sg["private-sg"].id
}

output "sg_public" {
  value = aws_security_group.sg["public-sg"].id
}

output "sg" {
  value = aws_security_group.sg
}

output "vpc_name" {
  value = aws_vpc.vpc
}

