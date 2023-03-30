# https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle

resource "random_integer" "integer" {
  min = 1
  max = 5

  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = true
    #ignore_changes = [ min , max ]
  }

}

output "nome" {
  value       = random_integer.integer.result
}

