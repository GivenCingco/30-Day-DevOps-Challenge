resource "aws_lb" "app_lb" {
  name               = "My-Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.LoadBalancerSG.security_group_id]
  subnets            = [data.aws_subnet.az1.id, data.aws_subnet.az2.id]
  depends_on         = [data.aws_vpc.default]


  tags = {
    Environment = "production"
  }
}

#Target group group for ALB
resource "aws_lb_target_group" "alb-target-group" {
  name        = "ALB-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"


  health_check {
    path                = "/highlights" # The health check endpoint
    interval            = 30        # Interval between health checks (in seconds)
    timeout             = 5         # Timeout for each health check (in seconds)
    healthy_threshold   = 3         # Number of consecutive successful checks
    unhealthy_threshold = 3         # Number of consecutive failed checks
    protocol            = "HTTP"
  }

  tags = {
    Name = "ALB-target-group"
  }
}

#Listerner for ALB
resource "aws_lb_listener" "alb-listerner" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

#Outputs
output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}