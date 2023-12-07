#Define launch config of servers to use in ASG (Auto-Scalling-Group)
resource "aws_launch_configuration" "ejemplo-instancia" {
    image_id = var.ami
    instance_type = var.instance_type
    security_groups = [aws_security_group.instance.id]

    #Render the user-data.sh file using "templatefile" Terraform built-in function.
    user_data = var.user_data

    #Since we are referencing ASG to launch config, we need Lifecycle to properly destroy the resource reference after being used
    lifecycle {
      create_before_destroy = true
    }
}
#ASG manages setting and creating the EC2 Instances.
resource "aws_autoscaling_group" "ejemplo" {
    name = var.cluster_name

    launch_configuration = aws_launch_configuration.ejemplo-instancia.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    #Here we provide the ASG a target group where to point to.
    target_group_arns = var.target_group_arns
    health_check_type = var.health_check_type

    min_size = var.min_size
    max_size =  var.max_size

    instance_refresh {
      strategy = "Rolling"
      preferences {
        min_healthy_percentage = 50
      }
    }

    tag {
        key = "Name"
        value = "${var.cluster_name}-ejemplo"
        propagate_at_launch = true
    }

    dynamic "tag" {
      for_each = {
        for key, value in var.custom_tags:
        key => upper(value)
        if key != "Name"
      }

      content {
        key = tag.key
        value = tag.value
        propagate_at_launch = true
      }
    }
}
#Security group allows traffic inward and outward.
resource "aws_security_group" "instance" {
    name = "${var.cluster_name}-instance"
}
#This resource allows the one above receive inbound request
resource "aws_security_group_rule" "allow_http_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.instance.id

  from_port = var.server_port
  to_port = var.server_port
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
}

#This resource will detect if auto_scaling is TRUE and then scale out during business hours
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "${var.cluster_name}-scale-out-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
  autoscaling_group_name = aws_autoscaling_group.ejemplo.name
}

#This resource will scale in during night time
resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "${var.cluster_name}-scale-in-at-night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
  autoscaling_group_name = aws_autoscaling_group.ejemplo.name
}

////////////////////////////////////////////LOCALS///////////////////////////////////////////////////
locals {
  http_port = 80 
  any_port = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips = ["0.0.0.0/0"]
}