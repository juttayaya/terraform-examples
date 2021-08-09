terraform {
  required_version = ">= 0.12.31"
  required_providers {
    aws = {
      version = "~> 3.38.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      app        = "Rocket Insights"
      created_by = "terraform"
      project    = "Project A"
    }
  }
}

provider "aws" {
  alias  = "alt-tags"
  region = "us-east-1"
  default_tags {
    tags = {
      modified = "Terraform"
      owner    = "Owner B"
    }
  }
}
