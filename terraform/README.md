# Terraform

Terraform configurations that power the infrastructure of Athena.

## Quick Start

1. Define `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` ENV vars for the S3 user
2. Define `TF_VAR_github_token` ENV var with a GitHub token to authenticate with the org
3. Run `terraform init`
4. Run `terraform plan` to see what needs to be updated (if anything)
