provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "examplee" {
  identifier_prefix = "upandrunning-practica-db"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  skip_final_snapshot = true

  #Enables replication based on days to mantain the replication on.
  backup_retention_period = var.backup_retention_period

  #If set to TRUE, that instance will become a replica.
  replicate_source_db = var.replicate_source_db

  # If 'var.replicate_source_db' is not set: engine, db_name, username and password will be set.
  engine = var.replicate_source_db == null ? "mysql" : null
  db_name = var.replicate_source_db == null ? var.db_name : null 
  username = var.replicate_source_db == null ? var.db_username : null
  password = var.replicate_source_db == null ? var.db_password : null
}

# This should be uncommented only after S3 bucket is on. Otherwise it will cause error when applying.

# terraform {
#   backend "s3" {
#     bucket = "terraform-federico-practica"
#     key = "stage/data-stores/mysql/terraform.tfstate"
#     region = "us-east-2"

#     dynamodb_table = "terraform-locks"
#     encrypt = true
#   }
# }

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

