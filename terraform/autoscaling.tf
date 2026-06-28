resource "aws_launch_template" "drupal_lt" {

  name_prefix = "drupal-launch-template-"

  image_id = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.drupal_sg.id
  ]

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name = "Drupal-ASG-Instance"
    }

  }

}
resource "aws_autoscaling_group" "drupal_asg" {

  desired_capacity = 2

  max_size = 4

  min_size = 2

  vpc_zone_identifier = [

    aws_subnet.public_subnet_1.id,

    aws_subnet.public_subnet_2.id

  ]

  launch_template {

    id = aws_launch_template.drupal_lt.id

    version = "$Latest"

  }

  target_group_arns = [

    aws_lb_target_group.drupal_tg.arn

  ]

  health_check_type = "ELB"

  tag {

    key = "Name"

    value = "Drupal-ASG"

    propagate_at_launch = true

  }

}
