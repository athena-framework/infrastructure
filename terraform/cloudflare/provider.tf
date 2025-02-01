terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "athena-framework"
    key          = "terraform/cloudflare.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_version = ">= 1.10.0"
}

provider "cloudflare" {
  api_token = var.api_token
}

resource "cloudflare_account" "blacksmoke16" {
  name = "Blacksmoke16"
  type = "standard"

  settings = {
    enforce_twofactor = true
  }
}
