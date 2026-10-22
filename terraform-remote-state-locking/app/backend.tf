terraform {
  backend "s3" {
    bucket         = "REPLACE_WITH_YOUR_S3_BUCKET_NAME"
    key            = "task-2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
