locals {
  shared_credentials_file = {
    "dev" = "***"
    "uat" = "***"
    "prd" = "***"
  }
}

variable "default_tags" {
    type = map(string)
    default = {
      Team: "infra",
      PC : "***",
      Project : "shorturl",
      IaC: "Terraform"
    }
  }

