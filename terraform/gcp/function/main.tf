resource "google_storage_bucket" "bucket_function" {
  name     = "bucket-function-${random_integer.sufix.result}"
  location = "us-central1"
}

resource "google_storage_bucket_object" "source" {
  name   = "source"
  bucket = google_storage_bucket.bucket_function.name
  source = "function-source.zip"
}

resource "google_cloudfunctions_function" "gen1-func-tf" {
  name        = "gen1-func-tf"
  description = "Função de testes - Terraform"
  runtime     = "nodejs16"
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket_function.name
  source_archive_object = google_storage_bucket_object.source.name
  trigger_http          = true
  entry_point           = "helloWorld"
}

resource "google_cloudfunctions_function_iam_member" "allow-access" {

  region         = google_cloudfunctions_function.gen1-func-tf.region
  cloud_function = google_cloudfunctions_function.gen1-func-tf.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions2_function" "gen2-func-tf" {
  name = "gen2-func-tf"
  location = "us-central1"
  description = "a new function"

  build_config {
    runtime = "nodejs16"
    entry_point = "helloHttp"  # Set the entry point 
    source {
      storage_source {
        bucket = google_storage_bucket.bucket_function.name
        object = google_storage_bucket_object.source.name
      }
    }
  }

  service_config {
    max_instance_count  = 1
    available_memory    = "256M"
    timeout_seconds     = 60
    all_traffic_on_latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  location = goog
}
