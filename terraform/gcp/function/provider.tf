terraform {
  required_version = ">=1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.56.0"
    }
  }
}

provider "google" {
  project     = "terraform-380221"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "../../.env/temaki.json"
}

resource "random_integer" "sufix" {
  min = 10000
  max = 99999
}
