
resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"
  remove_default_node_pool = true
  initial_node_count       = 1
  node_locations = [ "us-central1-c" ]
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }
  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.id
  node_count = 2

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    labels = {
      cle = "lab"  
    }

  }
}