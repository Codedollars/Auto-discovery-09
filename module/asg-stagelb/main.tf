# Application Load Balancer 
resource "aws_lb" "stage_alb" {
  name                       = var.alb_name
  security_groups            = var.vpc_security_group_ids
  subnets                    = var.subnet_id
  load_balancer_type         = "application"
  internal                   = false
  enable_deletion_protection = false
  tags = {
    Name = var.alb_name
  }
}

# Load Balancer Listener HTTP
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn =aws_lb.stage_alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stage_tg.arn
    }
}
# Load Balancer Listener HTTPS
resource "aws_lb_listener" "alb-listener-https" {
  load_balancer_arn =aws_lb.stage_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.cert-arn}"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stage_tg.arn
    }
}

# Load Balancer Target Group
resource "aws_lb_target_group" "stage_tg" {
  name     = var.tg_name
  vpc_id   = var.vpc_id
  port     = 8080
  protocol = "HTTP"
    health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
  }
}