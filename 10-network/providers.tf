terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  backend "s3" {
    key = "10-networking.tfstate"
  }
}

provider "aws" {
  default_tags {
    tags = {
      project          = "tfstateprj"
      "ops/managed-by" = "terraform"
    }
  }
}