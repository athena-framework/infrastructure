terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37"
    }
  }

  backend "s3" {
    bucket         = "athena-framework"
    key            = "terraform/aws.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}
