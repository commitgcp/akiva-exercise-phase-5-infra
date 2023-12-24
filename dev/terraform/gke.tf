locals {
  cluster_type           = "simple-autopilot-private"
  network_name           = "simple-autopilot-private-network"
  subnet_name            = "simple-autopilot-private-subnet"
  master_auth_subnetwork = "simple-autopilot-private-master-subnet"
  pods_range_name        = "ip-range-pods-simple-autopilot-private"
  svc_range_name         = "ip-range-svc-simple-autopilot-private"
  subnet_names           = [for subnet_self_link in module.gcp-network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
}


data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version = "~> 29.0"

  project_id                      = "akiva-exercise-phase5-dev"
  name                            = "dev-app-cluster"
  regional                        = true
  region                          = "us-central1"
  network                         = google_compute_network.vpc.name
  subnetwork                      = google_compute_subnetwork.subnet.name
  ip_range_pods                   = local.pods_range_name
  ip_range_services               = local.svc_range_name
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = true
  enable_private_endpoint         = true
  enable_private_nodes            = true
  master_ipv4_cidr_block          = "10.13.0.0/28"
  network_tags                    = [local.cluster_type]
  deletion_protection             = false

  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.7/32"
      display_name = "VPC"
    },
  ]
}