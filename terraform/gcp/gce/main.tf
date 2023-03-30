
resource "google_compute_instance" "vm-from-tf" {
  name = "vm-from-tf-${random_integer.sufix.result}"  
  zone = "us-central1-a"
  machine_type = "e2-medium"
  tags = [ "terraform", "vm-instance" ]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size = "20"
    }
  }
  network_interface {
    network = "default"
    access_config {
      
    }
  }
  labels = {
    "env" = "terraform-${random_integer.sufix.result}"
  }
  service_account {
    email = "terraform@terraform-380221.iam.gserviceaccount.com"
    scopes = [ "cloud-platform" ]
  }
  scheduling {
    preemptible = false
    automatic_restart = false
  }
  metadata_startup_script = "./script.sh"
  
}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15
  zone = google_compute_instance.vm-from-tf.zone
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "att-disk" {
  disk = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-from-tf.id
    
}

// terraform@terraform-380221.iam.gserviceaccount.com





