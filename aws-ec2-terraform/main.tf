terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

module "ec2" {
  source             = "./modules/ec2"
  instances          = var.instances
  ami_id             = data.aws_ssm_parameter.ubuntu.value
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  environment        = var.environment
  owner              = var.owner
}
