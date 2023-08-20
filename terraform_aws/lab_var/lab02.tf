locals {
  lab02 = {
    ##########################
    # EC2 CONFIG
    ##########################
    ec2 = {
      ec2_instance = {
        name              = "hieunh40"
        instance_type     = "t2.micro"
        ami               = "ami-053b0d53c279acc90"
        key_pair          = "hieunh"
        user_data         = file("${path.module}/user_data.tpl")
        subnet_name       = "public_subnet_1"
        availability_zone = "us-east-1a"
      }
    }
  }
}