terraform {
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
resource "aws_s3_bucket" "this" {
  bucket = "my-tf-test-bucket-992382674979"


  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


