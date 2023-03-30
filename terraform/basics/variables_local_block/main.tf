locals {
    content_question = "Quanto vc curte "
}

resource "local_file" "terraform" {
  filename = "terraform.txt"
  content = local.content_question
}

resource "local_file" "gcp" {
  filename = "gcp.txt"
  content = "${local.content_question}  GCP"
}

resource "local_file" "ansible" {
  filename = "ansible.txt"
  content = "${local.content_question}  Ansible"
}

