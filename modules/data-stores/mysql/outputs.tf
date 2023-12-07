output "address" {
  value = aws_db_instance.examplee.address
  description = "Connect to te Db at this endpoint."
}

output "port" {
  value = aws_db_instance.examplee.port
  description = "The port the DB is listening to."
}

output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
  description = "the domain name of the load balancer"
}

output "arn" {
  value = aws_db_instance.examplee.arn
  description = "the ARN of the DB."
}