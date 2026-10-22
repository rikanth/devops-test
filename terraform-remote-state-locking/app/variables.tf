variable "aws_region" {
  description = "AWS region for the application"
  type        = string
  default     = "ap-south-1"
}

variable "app_bucket_name" {
  description = "Globally unique name for the example application bucket"
  type        = string
}
