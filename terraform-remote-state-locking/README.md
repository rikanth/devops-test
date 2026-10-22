# Task 2 — Terraform Remote State & Locking

## Objective

Configure an S3 backend for remote Terraform state and a
DynamoDB table for state locking.

## Real-world scenario

Two engineers, Alice and Bob, manage the same infrastructure.

### Before: local state

Alice and Bob each have a local terraform.tfstate file.
If they run terraform apply concurrently, their local states
do not coordinate locking. They may work from stale state,
overwrite state information, or make conflicting changes.

### After: shared remote state

Both engineers use the same S3 backend and DynamoDB lock table.

1. Alice starts terraform apply and obtains the state lock.
2. Bob starts terraform apply while Alice holds the lock.
3. Terraform prevents Bob from acquiring the same lock.
   Depending on the command and lock timeout, Bob waits or
   receives a lock acquisition error.
4. Alice finishes, and Terraform releases the lock.
5. Bob can retry against the latest shared state.

Locking coordinates Terraform state operations. It does not
prevent every possible conflict caused by manual AWS changes.

## Architecture

- S3: stores shared Terraform state remotely.
- S3 versioning: helps recover earlier state versions.
- S3 encryption: encrypts stored state.
- S3 public-access block: prevents public bucket access.
- DynamoDB: coordinates state locking for this task.
- bootstrap/: declares the backend infrastructure.
- app/: declares an example workload using the backend.

## Important

This repository contains configuration files only.
Running this script does not contact AWS or create resources.

The bootstrap configuration must be deployed separately before
the app backend can be initialized. Replace the placeholder
bucket name in app/backend.tf with the real bucket name first.

DynamoDB-based S3 backend locking is deprecated in current
Terraform documentation. It is included because this assignment
explicitly requests DynamoDB locking.

## GitHub

Upload this project to a GitHub repository named
terraform-remote-state-locking.

Do not commit Terraform state files, credentials, or actual
terraform.tfvars files.
