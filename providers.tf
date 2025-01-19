terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Specify the version compatible with your setup
    }
  }

  required_version = ">= 1.0.0" # Ensure compatibility with your Terraform version
}

provider "aws" {
  region  = var.aws_region    # Use a variable to define the region
  profile = var.aws_profile   # Use a variable for the AWS CLI profile
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1" # Change this to your preferred AWS region
}

variable "aws_profile" {
  description = "The AWS CLI profile to use for authentication"
  type        = string
  default     = "default" # Change this to the AWS CLI profile you want to use
}
