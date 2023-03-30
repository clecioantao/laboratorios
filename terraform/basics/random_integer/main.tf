# https://registry.terraform.io/providers/hashicorp/random/latest/docs

resource "random_integer" "integer" {
  min = 1
  max = 50000
}

resource "random_string" "string" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output  "Integer" {
  value       = random_integer.integer.result
}

output  "string" {
  value       = random_string.string.result
}

output  "Password" {
  sensitive = true
  value       = random_password.password.result
}

