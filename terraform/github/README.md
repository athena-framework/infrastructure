# Terraform

Terraform configurations for the https://github.com/athena-framework organization.

## Quick Start

1. Define `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` ENV vars for the S3 user
1. Define `TF_VAR_github_token` ENV var with a GitHub token to authenticate with the org
1. Run `terraform init`
1. Run `terraform plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `terraform apply tfplan`
