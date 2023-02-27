terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Purpose   = "Bug Bounty"
      ManagedBy = "Terraform"
    }
  }
}

module "vps" {
  source = "../modules/vps"

  instance_type = "m5ad.large"
  key_name      = "bounty"
  ami           = "ami-052efd3df9dad4825"
  volume_size   = "70"

}
