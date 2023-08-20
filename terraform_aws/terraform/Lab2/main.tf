provider "aws" {
  region  = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


resource "aws_instance" "app_server" {
  ami           = "ami-053b0d53c279acc90" 
  instance_type = "t2.micro"
  key_name = var.key_name
  user_data = file("userdata.tpl")
  tags = {
    Name = "Nginx_Server"
  }


}


resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "nginx_demo" {
    name = "nginx_demo"
    description = "SSH on port 22 and HTTP on port 80"
    vpc_id = aws_default_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}