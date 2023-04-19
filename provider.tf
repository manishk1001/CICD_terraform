terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = "AKIAQIBNTGDX55JSXGHW"
  secret_key = "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"
}
