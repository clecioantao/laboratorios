
resource "random_integer" "sufix" {
  min = 10000
  max = 99999
}

resource "google_storage_bucket" "bucket1" {
  name = "bucket1_${random_integer.sufix.result}"
  location = "us-central1"
  storage_class = "STANDARD"
  uniform_bucket_level_access = false
  
  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
  # retention_policy {
  #   retention_period = 864000 // 10 dias
  # }
  labels = {
    "gcp" = "cloud-storage"
    "terraform" = "cs-object"
  }
}

resource "google_storage_bucket_object" "arq" {
  name = "arq_${random_integer.sufix.result}"
  source = "images/selos2.webp"
  bucket = google_storage_bucket.bucket1.name
}

resource "google_storage_bucket_access_control" "allow-file" {
  bucket = google_storage_bucket.bucket1.name
  role   = "READER"
  entity = "allUsers"
}



