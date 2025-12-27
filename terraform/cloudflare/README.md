# Terraform

Terraform configurations that power the DNS/networking infrastructure of Athena.

## Quick Start

1. Define `TF_VAR_cloudflare_api_token` ENV var with a Cloudflare API Token (`Zone.Zone Settings:Edit`, `Zone.DNS:Edit`, `Account:Read`, and `Page Rules:Edit`)
1. Run `terraform init`
1. Run `terraform plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `terraform apply tfplan`
