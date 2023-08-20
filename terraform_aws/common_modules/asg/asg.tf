resource "aws_launch_template" "web" {
    image_id      = var.ami
    instance_type = var.instance_type
    key_name      = var.key_pair
    user_data     = var.user_data
    tags = {
        Name = var.web_name
    }
    vpc_security_group_ids = [var.sg_asg]
}

resource "aws_autoscaling_group" "autoscalling_web" {
    name                = var.autoscalling_web
    desired_capacity    = var.desired_capacity
    min_size            = var.min_size 
    max_size            = var.max_size 
    vpc_zone_identifier = var.private_subnet_asg
    launch_template {
      id      = aws_launch_template.web.id
      version = aws_launch_template.web.latest_version
    }
    target_group_arns  = [var.target_group_arns] 
    

}