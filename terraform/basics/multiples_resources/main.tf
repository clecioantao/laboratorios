resource "local_file" "multiples_resources" {
  filename = "terraform.txt"
  content = "Multiplos recursos"
}

resource "local_file" "multiples_resources_gcp" {
  filename = "gcp.txt"
  content = "Multiplos  - GCP"
}