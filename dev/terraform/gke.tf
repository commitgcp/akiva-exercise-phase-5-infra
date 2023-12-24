resource "google_container_cluster" "primary" {
  name                     = "dev-app-cluster"
  location                 = "us-central1"
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet.name

  # networking_mode          = "VPC_NATIVE" 
  enable_autopilot = true
  
    node_config {
    preemptible  = true
    machine_type = "e2-standard-4"

    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes   = true 
    master_ipv4_cidr_block = "10.13.0.0/28"
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.11.0.0/21"
    services_ipv4_cidr_block = "10.12.0.0/21"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.7/32"
      display_name = "net1"
    }

  }
  deletion_protection = false
}
