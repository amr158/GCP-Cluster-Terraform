#####vpc
resource "google_compute_network" "gke-vpc" {
  project                 = "amr-gcp"
  name                    = "gke-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

#####subnets
resource "google_compute_subnetwork" "management" {
  name          = "management"
  ip_cidr_range = "10.0.1.0/24"
  region      = "us-central1"
  network       = google_compute_network.gke-vpc.id
}
resource "google_compute_subnetwork" "restricted" {
  name          = "restricted"
  ip_cidr_range = "10.0.2.0/24"
  region      = "us-central1"
  network       = google_compute_network.gke-vpc.id
}

#####router
resource "google_compute_router" "gke-router" {
  name    = "gke-router"
  region  = google_compute_subnetwork.management.region
  network = google_compute_network.gke-vpc.id
}

#####nat GW
resource "google_compute_router_nat" "nat" {
  name                               = "gke-router-nat"
  router                             = google_compute_router.gke-router.name
  region                             = google_compute_router.gke-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

   subnetwork {
    name                    = google_compute_subnetwork.management.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}