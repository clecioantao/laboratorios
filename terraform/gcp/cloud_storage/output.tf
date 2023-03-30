output "Labels" {
  value = google_storage_bucket.bucket1.labels
}

output "Access" {
  value = google_storage_bucket_access_control.allow-file
}