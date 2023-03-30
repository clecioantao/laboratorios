terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.56.0"
    }
  }
}

provider "google" {
  project     = "terraform-380221"
  region      = "us-central1"
  zone = "us-central1-a"
}

resource "google_storage_bucket" "bucket_user_pass" {
  name = "bucket_user_pass"
  location = "us-central1"

}