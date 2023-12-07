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