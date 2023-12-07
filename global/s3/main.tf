provider "aws" {
    region = "us-east-2"
}

resource "aws_s3_bucket" "s3-example" {
  bucket = "terraform-federico-practica"

  #This will remain comented in order to NOT use S3 to store the state file.
  #If we were to use it, 'prevent before destroy' would be a must to not lose our state file when
  #executing 'terraform destroy'.

  # lifecycle {
  #   prevent_destroy = true
  # }


  #'force destroy' should be used when S3 bucket its not empty and we want to destroy it.
  #Uncomment it, then 'terraform apply', wait until its done and finally 'terrraform destroy'.
  # force_destroy = true
 }

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.s3-example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.s3-example.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3-example.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# terraform {
#   backend "s3" {
#     #Your bucket name.
#     bucket = "terraform-federico-practica"
#     key = "global/s3/terraform.tfstate"
#     region = "us-east-2"

#     #Your DB table name.
#     dynamodb_table = "terraform-locks"
#     encrypt = true
#   }
# }

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3-example.arn
  description = "the ARN of the S3 bucket"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_locks.name
    description = "The name of the DB table"
}
