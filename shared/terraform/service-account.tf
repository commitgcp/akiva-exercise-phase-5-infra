resource "google_service_account" "infra_creator_account" {
  account_id   = "infra-creator-8763219872364"
  display_name = "Infra Creator"
}

resource "google_project_iam_member" "service_account_creator_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/iam.serviceAccountCreator"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "project_iam_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloud_sql_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_network_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "storage_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/storage.admin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "ar_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "ar_repo_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/artifactregistry.repoAdmin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "service_usage_admin_role" {
  project = "akiva-exercise-phase5-shared"
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "serviceAccount:infra-creator-8763219872364@akiva-exercise-phase5-shared.iam.gserviceaccount.com"
}

resource "google_artifact_registry_repository_iam_member" "repo-iam" {
  provider = google-beta

  location = "us-central1"
  repository = "dev-repo"
  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:code-builder-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
}

#resource "google_project_iam_member" "artifact_registry_writer_role" {
#  project = "akiva-exercise-phase5-shared"
#  role    = "roles/artifactregistry.writer"
#  member  = "serviceAccount:code-builder-1233431248900943@akiva-exercise-phase5-dev.iam.gserviceaccount.com"
#}
