variable "db_username" {
  description = "Username for MYSQL db"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "Passwqord for MYSQL db"
  type = string
  sensitive = true
}

variable "backup_retention_period" {
  description = "Days to retain backups. Must be > 0 to enable replication"
  type = number
  default = null
}

variable "replicate_source_db" {
  description = "If specified, replicate the RDS db at the given ARN"
  type = string
  default = null
}

variable "db_name" {
  description = "Name for the DB"
  type = string
  default = null
}

variable "db_username" {
  description = "username for the DB"
  type = string
  default = null
  sensitive = true
}

variable "db_password" {
  description = "password for the DB"
  type = string
  sensitive = true
  default = null
}