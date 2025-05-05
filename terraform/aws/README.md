# Terraform

Terraform configurations that power the IaC backend of Athena.
For now, requires root user to bootstrap.

## Quick Start

1. Define `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` ENV vars for the root AWS user
1. Run `terraform init`
1. Run `terraform plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `terraform apply tfplan`
