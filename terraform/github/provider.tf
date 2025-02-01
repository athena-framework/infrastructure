terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "athena-framework"
    key            = "terraform/github.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }

  required_version = ">= 1.10.0"
}

provider "github" {
  token = var.github_token
  owner = "athena-framework"
}
