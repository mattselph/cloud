# tool server
resource "google_compute_instance" "tool_server" {
  project      = var.project
  name         = var.tool_server_name
  description  = "Management server"
  zone         = var.subnet_public_zone
  machine_type = var.tool_server_machine_type

  tags = ["tool-srv"]

  network_interface {
    subnetwork = google_compute_subnetwork.subnets[var.subnet_public_zone].self_link
  }

  boot_disk {
    initialize_params {
      image = var.tool_server_image_family
      type  = var.tool_server_disk_type
      size  = var.tool_server_disk_size
    }
  }
  metadata_startup_script = templatefile("scripts/tools.tftpl", {
    apt = var.tool_server_packages
  })
}

# control plane
resource "google_compute_instance" "k8s_cp" {
  project      = var.project
  name         = var.k8s_cp_server_name
  description  = "Control plane"
  zone         = var.subnet_zones[0]
  machine_type = var.k8s_cp_machine_type

  tags = ["k8s-cp"]

  network_interface {
    subnetwork = google_compute_subnetwork.subnets[var.subnet_zones[0]].self_link
  }

  boot_disk {
    initialize_params {
      image = var.k8s_cp_image_family
      type  = var.k8s_cp_disk_type
      size  = var.k8s_cp_disk_size
    }
  }
}

# worker node
resource "google_compute_instance" "k8s_worker" {
  project      = var.project
  name         = var.k8s_worker_server_name
  description  = "Control plane"
  zone         = var.subnet_zones[0]
  machine_type = var.k8s_worker_machine_type

  tags = ["k8s-worker"]

  network_interface {
    subnetwork = google_compute_subnetwork.subnets[var.subnet_zones[0]].self_link
  }

  boot_disk {
    initialize_params {
      image = var.k8s_worker_image_family
      type  = var.k8s_worker_disk_type
      size  = var.k8s_worker_disk_size
    }
  }

}
