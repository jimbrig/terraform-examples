data "google_project" "project" {
  provider = google-beta
}

resource "google_secret_manager_secret" "secret" {
  provider = google-beta

  secret_id = "secret"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version-data" {
  provider = google-beta

  secret = google_secret_manager_secret.secret.name
  secret_data = "secret-data"
}

resource "google_secret_manager_secret_iam_member" "secret-access" {
  provider = google-beta

  secret_id = google_secret_manager_secret.secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
  depends_on = [google_secret_manager_secret.secret]
}

resource "google_cloud_run_service" "default" {
  provider = google-beta

  name     = "cloudrun-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
    volume_mounts {
      name = "a-volume"
      mount_path = "/secrets"
    }
      }
      volumes {
        name = "a-volume"
    secret {
      secret_name = google_secret_manager_secret.secret.secret_id
      items {
            key = "1"
        path = "my-secret"
      }
    }
      }
    }
  }

  metadata {
    annotations = {
      generated-by = "magic-modules"
      "run.googleapis.com/launch-stage" = "BETA"
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  autogenerate_revision_name = true

  lifecycle {
    ignore_changes = [
        metadata.0.annotations,
    ]
  }

  depends_on = [google_secret_manager_secret_version.secret-version-data]
}
