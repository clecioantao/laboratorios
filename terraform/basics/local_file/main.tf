resource "local_file" "example" {
  filename = "example.txt"
  content = "Testes com Terraform"
  file_permission = "0770"
}