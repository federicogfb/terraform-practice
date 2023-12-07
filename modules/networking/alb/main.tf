#Creating the aws load balancer.
resource "aws_lb" "loadbalancer" {
    name = var.alb_name
    load_balancer_type = "application"
    #Here we use the fetched subnets.
    subnets = data.aws_subnets.default.ids
    #Pointing the load balancer to our security group managing requests.
    security_groups = [aws_security_group.lb-securitygroup.id]
}
#Creating the lb's listener.
resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.loadbalancer.arn
    port = local.http_port
    protocol = "HTTP"

    #Setting error message.
    default_action {
      type = "fixed-response"

      fixed_response {
        content_type = "text/plain"
        message_body = "404: page not found"
        status_code = 404
      }
    }
}

#Creating security group specifically to Amazon Load Balancer.
resource "aws_security_group" "lb-securitygroup" {

  name = var.alb_name

}
#Allows inbound request to the resource from above
resource "aws_security_group_rule" "allow_http_inbound_loadbalancer" {
  type = "ingress"
  security_group_id = aws_security_group.lb-securitygroup.id

  from_port = local.http_port
  to_port = local.http_port
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
}
#Allows outside connection to the one above above
resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  security_group_id = aws_security_group.lb-securitygroup.id

  from_port = local.any_port
  to_port = local.any_port
  protocol = local.any_protocol
  cidr_blocks = local.all_ips
}

locals {
  http_port = 80 
  any_port = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips = ["0.0.0.0/0"]
}