terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("defaultproject-default-service-account-key.json")

  project = "defaultproject-321020"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
