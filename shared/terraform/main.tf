provider "google" {
  project     = "akiva-exercise-phase5-shared"
  region      = "us-central1" 
}
provider "google-beta" {
  project     = "akiva-exercise-phase5-shared"
  region      = "us-central1" 
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "artifactregistry.googleapis.com",
    "iam.googleapis.com"
  ]
}

resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  project = "akiva-exercise-phase5-shared"
  service = each.key
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 5.0"

  name       = "phase5-bucket"
  project_id = "akiva-exercise-phase5-shared"
  location   = "us-central1"
  iam_members = [{
    role   = "roles/storage.objectUser"
    member = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
  },
  {
    role   = "roles/storage.objectUser"
    member = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"    
  }]
}

resource "google_artifact_registry_repository" "dev-repository" {
  location      = "us-central1"
  repository_id = "dev-repo"
  description   = "docker repository"
  format        = "DOCKER"
}