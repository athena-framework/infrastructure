# Cloudflare

Manages DNS, Pages, and email infrastructure for the Athena Framework via OpenTofu.

## Resources

- **Zones**: `athenaframework.org` (primary) and `athena-framework.org` (redirect)
- **DNS records**: CNAME records for root, `www`, and `dev` subdomains
- **Cloudflare Pages**: `athenaframework` project with custom domains for root and `dev`
- **Redirect rules**: `athena-framework.org` → `athenaframework.org` (301)
- **Email (SimpleLogin)**: MX, SPF, DKIM, and DMARC records
- **Zone settings**: DNSSEC, HSTS, forced HTTPS, Brotli compression

## Quick Start

1. Define `CLOUDFLARE_API_TOKEN` ENV var with a Cloudflare API Token (`Zone.Zone Settings:Edit`, `Zone.DNS:Edit`, `Account:Read`, and `Page Rules:Edit`)
1. Run `tofu init`
1. Run `tofu plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `tofu apply tfplan`
