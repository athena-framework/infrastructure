terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.24"
    }
  }

  backend "s3" {
    bucket  = "athena-framework"
    key     = "terraform/github.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_version = ">= 1.1.0"
}

provider "github" {
  token = var.github_token
  owner = "athena-framework"
}
