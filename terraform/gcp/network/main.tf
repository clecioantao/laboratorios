
resource "random_integer" "sufix" {
  min = 10000
  max = 99999
}

resource "google_compute_network" "auto-vpc-tf" {
  name = "auto-vpc-tf-${random_integer.sufix.result}"
  auto_create_subnetworks = true
}

resource "google_compute_network" "custom-vpc-tf" {
  name = "custom-vpc-tf-${random_integer.sufix.result}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sbnet" {
  name = "subnet-${random_integer.sufix.result}"
  network = google_compute_network.custom-vpc-tf.id
  region = "us-central1"
  ip_cidr_range = "10.1.0.0/24"
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow-icmp" {
  name    = "allow-icmp-${random_integer.sufix.result}"
  network = google_compute_network.custom-vpc-tf.id
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
  
  source_ranges = ["177.81.83.164"]
  priority = 500
}



