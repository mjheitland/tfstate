terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  # Uncomment the lines below if you want to store the local state of this module into the state bucket that it is generating
  #  backend "s3" {
  #    key = "00-tfstate.tfstate"
  #  }
}
