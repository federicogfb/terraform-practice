provider "aws" {
  region = "us-east-2"
  alias = "primary"
}

provider "aws" {
  region = "us-west-1"
  alias = "replica"
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name = "staging_db"
  db_username = var.db_username
  db_password = var.db_password

  #Must be > 0 to support replication.
  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  #Replicate "mysql_primary" into a read only db for backup.
  replicate_source_db = module.mysql_primary.arn
}

