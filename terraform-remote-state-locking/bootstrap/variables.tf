variable "aws_region" {
  description = "AWS region for the remote state infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  type        = string
  default     = "terraform-state-locks"
}
