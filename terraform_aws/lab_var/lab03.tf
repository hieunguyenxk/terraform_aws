locals {
  lab03 = {
    ##########################
    # EC2 CONFIG
    ##########################
    ec2 = {
      "server_1" = {
        name              = "hieunh40_1"
        instance_type     = "t2.micro"
        ami               = "ami-053b0d53c279acc90"
        key_pair          = "hieunh"
        user_data         = file("${path.module}/user_data.tpl")
        subnet_name       = "public_subnet_1"
        availability_zone = "us-east-1a"
        vpc_name          = "vpc-test"
      }
      "server_2" = {
        name              = "hieunh40_2"
        instance_type     = "t2.micro"
        ami               = "ami-053b0d53c279acc90"
        key_pair          = "hieunh"
        user_data         = ""
        subnet_name       = "private_subnet_1"
        availability_zone = "us-east-1a"
        vpc_name          = "vpc-test"
      }
    }

    vpc = {
      vpc_test = {
        vpc_name               = "vpc_test"
        vpc_cidr_block         = "10.0.0.0/16"
        cidr_block_rtb_public  = "0.0.0.0/0"
        cidr_block_rtb_private = "0.0.0.0/0"
        subnet_configs = {
          "public_subnet_01" = {
            public            = true
            cidr_block        = "10.0.1.0/24"
            availability_zone = "us-east-1a"
          }
          "public_subnet_02" = {
            public            = true
            cidr_block        = "10.0.2.0/24"
            availability_zone = "us-east-1b"
          }
          "private_subnet_01" = {
            public            = false
            cidr_block        = "10.0.3.0/24"
            availability_zone = "us-east-1a"
          }
          "private_subnet_02" = {
            public            = false
            cidr_block        = "10.0.4.0/24"
            availability_zone = "us-east-1b"
          }
        }
        sg_configs = {
          "public-sg" = {
            ingress = [
              {
                from     = "22"
                to       = "22"
                protocol = "tcp"
                cidr     = ["0.0.0.0/0"]
              },
              {
                from     = "80"
                to       = "80"
                protocol = "tcp"
                cidr     = ["0.0.0.0/0"]
              }
            ]
          }
          "private-sg" = {
            ingress = [
              {
                from     = "22"
                to       = "22"
                protocol = "tcp"
                cidr     = ["10.0.0.0/16"]
              }
            ]

          }
        }
      }
    }

  }
}