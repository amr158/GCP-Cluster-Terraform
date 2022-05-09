resource "google_service_account" "cluster_admin" {
  account_id = "cluster-admin"
  display_name = "k8s-admin"
}

resource "google_project_iam_member" "admin_binding" {
  project = "amr-gcp"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.cluster_admin.email}"
}



resource "google_service_account" "node-acc" {
  account_id = "node-acc"
  display_name = "node-acc"
}

resource "google_project_iam_member" "node_binding" {
  project = "amr-gcp"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.node-acc.email}"
}