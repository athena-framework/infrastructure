# AWS

Manages IAM and the S3 state bucket for the Athena Framework.

## Resources

- **IAM user**: `admin` — primary operator with `AmazonS3FullAccess` and `IAMFullAccess` managed policies attached
- **S3 bucket**: `athena-framework` — stores OpenTofu state with versioning, encryption (AES256), and all public access blocked

## Bucket Policy

The bucket policy enforces a single rule: all requests must use TLS.

## Quick Start

1. Define `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` ENV vars for the `admin` IAM user
1. Run `tofu init`
1. Run `tofu plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `tofu apply tfplan`
