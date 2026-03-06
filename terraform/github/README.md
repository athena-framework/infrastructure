# GitHub

Manages the [athena-framework](https://github.com/athena-framework) GitHub organization via OpenTofu.

## Resources

- **Org membership**: `PallasAthenaie` CI bot user
- **CI team**: Secret team granting CI push access to component repos
- **Component repos**: Created via a reusable module with standardized settings, branch protection, issue labels, and a `docs` branch
- **Non-component repos**: `athena` (monorepo), `infrastructure`, `website` (archived), `skeleton`, `demo`
- **Branch protection**: Enforced on `master` for all repos
- **Issue labels**: Shared label set on the `athena` repo (kind, state, component, etc.)

## Quick Start

1. Define `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` ENV vars for the S3 state backend
1. Define `TF_VAR_github_token` ENV var with a GitHub token to authenticate with the org
1. Run `tofu init`
1. Run `tofu plan -out=tfplan` to see what needs to be updated (if anything)
1. Run `tofu apply tfplan`
