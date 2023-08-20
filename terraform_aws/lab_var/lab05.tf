locals {
  lab05 = {
    # ec2 = {
    #   "web" = {
    #     name              = "web"
    #     instance_type     = "t2.micro"
    #     ami               = "ami-053b0d53c279acc90"
    #     key_pair          = "hieunh"
    #     user_data         = file("${path.module}/user_data.tpl")
    #  }
    # }

    vpc = {
      "vpc_test" = {
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

    asg = {
      "asg-web" = {
        ami              = "ami-053b0d53c279acc90"
        instance_type    = "t2.micro"
        key_pair         = "hieunh"
        user_data        = filebase64("${path.module}/user_data.tpl")
        web_name         = "web"
        autoscalling_web = "asg-web"
        desired_capacity = 2
        min_size         = 1
        max_size         = 3


      }
    }

      alb = {
        "alb-web" = {
          alb_name           = "alb-web"
          internal           = false
          load_balancer_type = "application"
          alb_tg_name        = "alb-tg-web"
          port               = 80
          protocol           = "HTTP"
          alb_listener_port  = 80
        }
      }

    }
 }
  