terraform {
  required_providers {
    google = {
      source = "hashicorp/google-beta"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.3"
    }
  }

  backend "gcs" {
    bucket = "mattselph-cbm-tf-state"
    prefix = "infrastructure"
  }
}

provider "google" {
  project = "mattselph-cbm"
  region  = "us-east1"
}

