variable "db_remote_state_bucket" {
  description = "Name of the S3 bucket for the database remote state"
  type = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type = string
}

variable "server_text" {
  description = "the text the web server should return"
  type = string
  default = "Hello, World"
}

variable "environment" {
  description = "The name of the environment we're deploying to."
  type = string
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}
