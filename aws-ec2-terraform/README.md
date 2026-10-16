# AWS EC2 Provisioning with Terraform

A learning project demonstrating a reusable Terraform module for five
differently configured EC2 instances.

Features:
- One input map and for_each
- Different EC2 instance and root volume types
- io1/io2 provisioned IOPS examples
- Standard ownership and environment tags
- Deletion protection for critical-db
- Instance ID and private IP outputs
- Encrypted root volumes and IMDSv2

See NOTES.md for design decisions and deployment instructions.

Use terraform.tfvars.example as a template. Replace all placeholders
with real AWS values before planning. This project creates billable resources.
