resource "google_compute_instance" "private"{
  name         = "private"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.management.id
  }
  
  service_account {
    email  = google_service_account.cluster_admin.email
    scopes = ["cloud-platform"]
  }

}
resource "google_compute_instance" "test"{
  name         = "test"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.restricted.id
  }

}
