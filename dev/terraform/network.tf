
# create VPC
resource "google_compute_network" "vpc" {
  name                    = local.network_name
  auto_create_subnetworks = false
}

# Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "subnet1"
  region        = "us-central1"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.0.0.0/24"
}

## Create jump host . We will allow this jump host to access GKE cluster. the ip of this jump host is already authorized to allowin the GKE cluster

resource "google_compute_address" "my_internal_ip_addr" {
  project      = "akiva-exercise-phase5-dev"
  address_type = "INTERNAL"
  region       = "us-central1"
  subnetwork   = local.master_auth_subnetwork
  name         = "jump-ip"
  address      = "10.0.0.7"
  description  = "An internal IP address for my jump host"
}

resource "google_compute_instance" "default" {
  project      = "akiva-exercise-phase5-dev"
  zone         = "us-central1-a"
  name         = "jump-host"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = local.network_name
    subnetwork = local.master_auth_subnetwork
    network_ip         = google_compute_address.my_internal_ip_addr.address
  }

}


## Create Firewall to access jump hist via iap


resource "google_compute_firewall" "rules" {
  project = "akiva-exercise-phase5-dev"
  name    = "allow-ssh"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}



## Create IAP SSH permissions for your test instance
#
#resource "google_project_iam_member" "project" {
#  project = "akiva-exercise-phase5-dev"
#  role    = "roles/iap.tunnelResourceAccessor"
#  member  = "serviceAccount:terraform-demo-aft@tcb-project-371706.iam.gserviceaccount.com"
#}


# create cloud router for nat gateway
resource "google_compute_router" "router" {
  project = "akiva-exercise-phase5-dev"
  name    = "nat-router"
  network = local.network_name
  region  = "us-central1"
}

## Create Nat Gateway with module

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 1.2"
  project_id = "akiva-exercise-phase5-dev"
  region     = "us-central1"
  router     = google_compute_router.router.name
  name       = "nat-config"

}

