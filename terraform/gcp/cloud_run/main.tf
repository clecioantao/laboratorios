resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/google-samples/hello-app:1.0"
      }
    }
  }

  traffic {
    percent         = 50
    revision_name = "cloudrun-srv-tlhn4"
  }

  traffic {
    percent         = 50
    revision_name = "cloudrun-srv-hzqwk"
  }

}

resource "google_cloud_run_service_iam_policy" "pub_access" {
  service = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  policy_data = data.google_iam_policy.pub1.policy_data
}

data "google_iam_policy" "pub1" {
  binding {
    role = "roles/run.invoker"
    members = [ "allUsers" ]
  }
  
}

