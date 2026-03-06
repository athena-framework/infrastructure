# Terraform

Terraform configurations that power the DNS/networking infrastructure of Athena.

## Quick Start

1. Define `CLOUDFLARE_API_TOKEN` ENV var with a Cloudflare API Token (`Zone.Zone Settings:Edit`, `Zone.DNS:Edit`, `Account:Read`, and `Page Rules:Edit`)
1. Run `tofu init`
1. Run `tofu plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `tofu apply tfplan`
