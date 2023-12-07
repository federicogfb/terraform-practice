output "primary_address" {
  value = module.mysql_primary.address
  description = "Connect to the primary database at this endpoint."
}

output "primary_port" {
  value = module.mysql_primary.port
  description = "the port the primary db is listening to."
}

output "primary_arn" {
  value = module.mysql_primary.arn
  description = "the ARN of the primary db."
}

output "replica_address" {
  value = module.mysql_replica.address
  description = "Connect to the replica database at this endpoint."
}

output "replica_port" {
  value = module.mysql_replica.port
  description = "the port the replica db is listening to."
}

output "replica_arn" {
  value = module.mysql_replica.arn
  description = "the ARN of the replica db."
}