resource "google_storage_bucket" "bucket_function" {
  name     = "bucket-function-${random_integer.sufix.result}"
  location = "us-central1"
}

resource "google_storage_bucket_object" "source" {
  name   = "source"
  bucket = google_storage_bucket.bucket_function.name
  source = "source.zip"
}

resource "google_cloudfunctions_function" "gen1_func_tf" {
  name        = "gen1-func-tf-${random_integer.sufix.result}"
  description = "Função de testes - Terraform"
  runtime     = "nodejs18"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket_function.name
  source_archive_object = google_storage_bucket_object.source.name
  trigger_http          = true
  entry_point           = "helloWorld69"
}

resource "google_cloudfunctions_function_iam_member" "allow-access" {

  region         = google_cloudfunctions_function.gen1_func_tf.name
  cloud_function = google_cloudfunctions_function.gen1_func_tf

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}