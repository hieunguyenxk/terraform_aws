locals {
  global_variables = {
    environment = "prod"
    owner       = "thangtd18"
    project     = "gr3"
  }

  tags = {
    environment    = "dev"
    owner          = "ThangTD18"
    name           = "ThangTD18"
    project        = "gr3"
    provisioned_by = "terraform"
  }
}