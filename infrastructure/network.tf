# Create networking resources

resource "google_compute_network" "vpc" {
  project                         = var.project
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = toset(var.subnet_zones)
  project       = var.project
  name          = "net${var.subnet_public_zone == each.value ? "-${var.subnet_public_zone_prefix}" : ""}-${element(split("-", each.value), 1)}-${element(split("-", each.value), 2)}"
  ip_cidr_range = cidrsubnet(var.vpc_cidr, 4, index(var.subnet_zones, each.value) + 1)
  network       = google_compute_network.vpc.id
  region        = "${element(split("-", each.value), 0)}-${element(split("-", each.value), 1)}"

  log_config {
    aggregation_interval = var.subnet_flow_log_aggregation_interval
    flow_sampling        = var.subnet_flow_log_sample_rate
    metadata             = var.subnet_flow_log_metadata_captured
  }
}

resource "google_compute_router" "router" {
  project = var.project
  name    = var.cloud_nat_router_name
  region  = google_compute_subnetwork.subnets[var.subnet_public_zone].region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  project = var.project
  name    = "cloud-nat"
  router  = google_compute_router.router.name
  region  = google_compute_router.router.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_route" "route_internet" {
  project          = var.project
  name             = "internet"
  description      = "Default route to the internet"
  network          = google_compute_network.vpc.id
  dest_range       = "0.0.0.0/0"
  tags             = ["tool-srv", "k8s-cp", "k8s-worker"]
  next_hop_gateway = "default-internet-gateway"
  priority         = 0
}
