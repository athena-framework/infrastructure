# Terraform

Terraform configurations that power the infrastructure of Athena.

## Quick Start

1. Define `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` ENV vars for the S3 user
1. Run `terraform init`
1. Run `terraform plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `terraform apply tfplan`
