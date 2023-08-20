resource "aws_instance" "instance" {
  ami = var.ami

  subnet_id              = var.subnet_ids[var.subnet_name].id
  vpc_security_group_ids = [var.sg_ids[var.sg_name].id]

  instance_type = var.instance_type
  user_data     = var.user_data
  key_name      = var.key_pair
  tags = {
    Name = var.name
  }
}