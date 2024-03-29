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
    dynamodb_table = "terraform-state"
  }

  required_version = ">= 1.5.0"
}

provider "github" {
  token = var.github_token
  owner = "athena-framework"
}
