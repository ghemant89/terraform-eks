terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.15"
    }
  }
  required_version = ">= 1.3.0"
}