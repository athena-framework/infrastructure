terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.28"
    }
  }

  backend "s3" {
    bucket         = "athena-framework"
    key            = "terraform/aws.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }

  required_version = ">= 1.10.0"
}

provider "aws" {
  region = "us-east-1"
}
