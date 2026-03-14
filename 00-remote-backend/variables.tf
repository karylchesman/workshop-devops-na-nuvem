variable "tags" {
  type = map(string)
  default = {
    "Environment" = "production"
    "Project"     = "workshop-devops-na-nuvem"
  }
}

variable "assume_role" {
  type = object({
    arn    = string
    region = string
  })

  default = {
    arn    = "arn:aws:iam::629614691642:role/workshop-march"
    region = "us-east-1"
  }
}

variable "remote_backend" {

  type = object({
    s3_bucket_name             = string
    dynamo_table_name          = string
    dynamo_billing_mode        = string
    dynamo_table_hash_key      = string
    dynamo_table_hash_key_type = string
  })

  default = {
    s3_bucket_name             = "workshop-march-remote-backend"
    dynamo_table_name          = "workshop-march-state-locking-table"
    dynamo_billing_mode        = "PAY_PER_REQUEST"
    dynamo_table_hash_key      = "LockID"
    dynamo_table_hash_key_type = "S"
  }
}