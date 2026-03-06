# Infrastructure

OpenTofu configurations that manage the Athena Framework's infrastructure.

## Directory Structure

- **`terraform/aws`** — IAM users and S3 state bucket
- **`terraform/cloudflare`** — DNS zones, Pages, email records, and redirect rules
- **`terraform/github`** — GitHub org membership, teams, repos, branch protection, and issue labels

## Prerequisites

- [OpenTofu](https://opentofu.org/) >= 1.10.0
- AWS credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) for the S3 state backend
- Cloudflare API token (`CLOUDFLARE_API_TOKEN`) for DNS/Pages management
- GitHub token (`GITHUB_TOKEN`) for org management

Each directory is an independent root module — see its README for usage details.
