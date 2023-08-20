locals {
  lab_file = {
    "lab01" : local.lab01,
    "lab02" : local.lab02,
    "lab03" : local.lab03,
    "lab04" : local.lab04,
    "lab05" : local.lab05
  }
}

output "configuration" {
  value = local.lab_file["${var.lab_file}"]
}

output "global_variables" {
  value = local.global_variables
}

output "tags" {
  value = local.tags
}
