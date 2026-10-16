# AWS EC2 Terraform Project

Provisions five EC2 instances using one instances map and a reusable module.

## Design
- Uses for_each to create instances from input data.
- Uses two resource blocks because lifecycle settings are static.
- Encrypts root EBS volumes and requires IMDSv2.
- Applies Name, Environment, and Owner tags.
- Exports instance ID and private IP maps.

## Deletion protection
critical-db has lifecycle.prevent_destroy = true because accidental
deletion of a critical database workload could cause an outage or data loss.
This is not a backup. Terraform protection does not replace backups or recovery.

## Prerequisites
- Terraform and AWS CLI installed
- AWS credentials configured
- Existing subnet and security group
- Five existing EC2 key pairs in the chosen region
- Permissions to read the Ubuntu AMI parameter and create EC2/EBS resources

## Deployment
1. Copy terraform.tfvars.example to terraform.tfvars.
2. Replace placeholder IDs and key names with real values.
3. Run terraform init.
4. Run terraform fmt -recursive.
5. Run terraform validate.
6. Review terraform plan before applying.
7. Run terraform apply only after reviewing costs and changes.

Never commit credentials, private keys, Terraform state, or saved plans.
