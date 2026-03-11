terraform {
  required_version = "~> 1.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"

}
provider "cloudflare" {
  email   = var.cloudflare_email     # or directly: "your@email.com"
  api_key = var.cloudflare_api_key   # or directly from secrets
}


terraform {
  required_version = ">= 1.0.0"  
  backend "s3" {
    bucket  = "my-tf-test-bucket-992382674979"
    key     = "state"
    region  = "eu-west-2"
    encrypt = true
  }
}