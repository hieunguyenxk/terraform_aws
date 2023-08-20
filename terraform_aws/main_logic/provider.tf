provider "aws" {
  region  = "us-east-1"
  profile = "FADevOps"
}

terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}