provider "aws" {
  region                  = "ap-southeast-1"
  shared_credentials_file = local.shared_credentials_file[terraform.workspace]
}

