resource "google_service_account" "infra_creator_account" {
  account_id   = "infra-creator-1233431248900943"
  display_name = "Infra Creator"
}

resource "google_project_iam_member" "service_account_creator_role" {
  project = "akiva-exercise-phase5-dev"
  role    = "roles/iam.serviceAccountCreator"
  member  = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "project_iam_admin_role" {
  project = "akiva-exercise-phase5-dev"
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "service_usage_admin_role" {
  project = "akiva-exercise-phase5-dev"
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloud_sql_admin_role" {
  project = "akiva-exercise-phase5-dev"
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_network_admin_role" {
  project = "akiva-exercise-phase5-dev"
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "gke_cluster_admin_role" {
  project = "akiva-exercise-phase5-dev"
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:infra-creator-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}


resource "google_service_account" "code_builder_account" {
  account_id   = "code-builder-1233431248900943"
  display_name = "Code Builder"
}




