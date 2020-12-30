provider "aws" {
    region = var.region
}

terraform {
  required_version = "0.13.4"
  backend "s3" {
    bucket         = "tf-us-east-2-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}

