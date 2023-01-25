# Firewall rules

resource "google_compute_firewall" "allow_icmp" {
  project       = var.project
  name          = "allow-icmp"
  description   = "Allow ping on the network"
  network       = google_compute_network.vpc.self_link
  priority      = 1000
  source_ranges = [var.vpc_cidr]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_dns" {
  project       = var.project
  name          = "allow-dns"
  description   = "Allow dns on the network"
  network       = google_compute_network.vpc.self_link
  priority      = 1000
  source_ranges = [var.vpc_cidr]

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  project       = var.project
  name          = "allow-ssh"
  description   = "Allow ssh on the network"
  network       = google_compute_network.vpc.self_link
  priority      = 1000
  source_ranges = [var.vpc_cidr]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow_all_traffic" {
  project     = var.project
  name        = "allow-all"
  description = "Allow all traffic"
  network     = google_compute_network.vpc.self_link
  direction   = "INGRESS"
  priority    = 1000

  allow {
    protocol = "tcp"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  target_tags = ["tool-srv", "k8s-cp", "k8s-worker"]
  source_tags = ["tool-srv", "k8s-cp", "k8s-worker"]
}

# https://kubernetes.io/docs/reference/ports-and-protocols/
#resource "google_compute_firewall" "allow_k8s_ports" {
#  project       = var.project
#  name          = "allow-k8s-traffic"
#  description   = "Allow all kubernetes port traffic on the network"
#  network       = google_compute_network.vpc.id
#  priority      = 1000
#  source_ranges = [var.vpc_cidr]

#  allow {
#    protocol = "tcp"
#    ports    = ["443", "2379-2380", "6443", "10250", "10257", "10259", "30000-32767"]
#  }

#  log_config {
#    metadata = "INCLUDE_ALL_METADATA"
#  }
#}

resource "google_compute_firewall" "allow_tool_server_egress" {
  project     = var.project
  name        = "allow-tool-srv-egress"
  description = "Allow tool server to access the internet"
  network     = google_compute_network.vpc.self_link
  direction   = "EGRESS"
  priority    = 2000

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  target_tags        = ["tool-srv"]
  destination_ranges = ["0.0.0.0/0"]
}
