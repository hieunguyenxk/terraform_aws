resource "aws_lb" "web" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.sg_alb]
  subnets            = var.subnet_alb
}

resource "aws_lb_target_group" "web" {
  name     = var.alb_tg_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
    
    health_check {
      enabled = true
      healthy_threshold = 2
      unhealthy_threshold = 2
      interval = 10
      matcher = 200
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 3
      
    }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = var.alb_listener_port
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}