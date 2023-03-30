resource "local_file" "example" {
  filename = var.fname
  content = var.cont
  file_permission = var.perm
}

resource "random_shuffle" "az" {
  input = var.zones
}

output "Zonas" {
    value = random_shuffle.az.result
}
 