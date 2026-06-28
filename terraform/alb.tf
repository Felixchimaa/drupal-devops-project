########################################
# Application Load Balancer
########################################

resource "aws_lb" "drupal_alb" {
  name               = "drupal-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.drupal_sg.id
  ]

  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "Drupal-ALB"
  }
}

########################################
# Target Group
########################################

resource "aws_lb_target_group" "drupal_tg" {
  name     = "drupal-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.drupal_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Drupal-TG"
  }
}

########################################
# Attach EC2 Instance 1
########################################

resource "aws_lb_target_group_attachment" "server1" {
  target_group_arn = aws_lb_target_group.drupal_tg.arn
  target_id        = aws_instance.drupal_server_1.id
  port             = 80
}

########################################
# Attach EC2 Instance 2
########################################

resource "aws_lb_target_group_attachment" "server2" {
  target_group_arn = aws_lb_target_group.drupal_tg.arn
  target_id        = aws_instance.drupal_server_2.id
  port             = 80
}

########################################
# Listener
########################################

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.drupal_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.drupal_tg.arn
  }
}
