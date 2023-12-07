output "asg_name" {
  value = module.asg.asg_name
  description = "the name of the ASG"
}

#Shows public ip after terraform apply.
output "alb_dns_name" {
    value = module.alb.alb_dns_name
    description = "The DNS of the load balancer"
}

# output "alb_security_group_id" {
#   value = aws_security_group.lb-securitygroup.id
#   description = "the ID of the Security Group attached to the load balancer"
# }

output "instance_security_group_id" {
  value = module.asg.instance_security_group_id
  description = "The ID of the EC2 Instance Security Group."
}