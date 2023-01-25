terraform {
  required_providers {
    google = {
      source = "hashicorp/google-beta"
    }
  }
}

provider "google" {
  project = "mattselph-cbm"
  region  = "us-east1"
}

