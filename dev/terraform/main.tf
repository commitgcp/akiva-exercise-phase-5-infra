provider "google" {
  project     = "akiva-exercise-phase5-dev"
  region      = "us-central1" 
}

provider "google-beta" {
  project     = "akiva-exercise-phase5-dev"
  region      = "us-central1" 
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "sqladmin.googleapis.com",
    "artifactregistry.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com"
  ]
}

resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  project = "akiva-exercise-phase5-dev"
  service = each.key
}

resource "google_sql_database_instance" "instance" {
  provider = google-beta
  project = "akiva-exercise-phase5-dev"
  name             = "phase5-dev-db"
  region           = "us-central1"
  database_version = "POSTGRES_13"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = true
    }
  }
}

#Create a Cloud SQL database (PostgreSQL)
resource "google_sql_database" "app_database" {
  name     = "app-database"
  instance = google_sql_database_instance.instance.name
}

# Create a Cloud SQL user (PostgreSQL)
resource "google_sql_user" "app_db_user" {
  name     = "app-db-user"
  instance = google_sql_database_instance.instance.name
  password = "pass" 
}

#