variable "alb_name" {
  description = "The name used for this ALB."
  type = string
}

variable "subnets_ids" {
  description = "The subnet IDs to deploy to"
  type        = list(string)
}