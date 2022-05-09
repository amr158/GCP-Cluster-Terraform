resource "google_compute_firewall" "nodes-ssh-firewall" {
  name    = "nodes-ssh-firewall"
  network = google_compute_network.gke-vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]

}
