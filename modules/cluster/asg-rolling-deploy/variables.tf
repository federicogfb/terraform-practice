variable "server_port" {
    description = "The port the server will use."
    type = number
    default = 8080
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources."
  type = string
}

variable "instance_type" {
  description = "the type of EC2 instances to run (ej: t2.micro)"
  type = string
}

variable "min_size" {
  description = "the minimum number of EC2 instances in the ASG"
  type = number
}

variable "max_size" {
  description = "the maximum number of  EC2 instances running in the ASG"
  type = number
}

variable "custom_tags" {
  description = "custom tags to set on the instances in the ASG"
  type = map(string)
  default = {}
}

variable "enable_autoscaling" {
  description = "If set to TRUE, enable auto scaling"
  type = bool
}

variable "ami" {
  description = "the AMI to run in the cluster"
  type = string
  default = "ami-0fb653ca2dd3203ac1"
}

variable "subnets_ids" {
  description = "The subnets IDs to deploy to."
  type = list(string)
}

variable "target_group_arns" {
  description = "The ARNs of ELB target groups in wich to register instances."
  type = list(string)
  default = []
}

variable "health_check_type" {
  description = "The type of health check to perfom. Must be one of: EC2, ELB."
  type = string
  default = "EC2"
}

variable "user_data" {
  description = "The User Data script to run in each instance at boot."
  type = string
  default = null
}