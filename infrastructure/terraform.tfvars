project = "mattselph-cbm"

api = [
  "container.googleapis.com",
  "secretmanager.googleapis.com",
  "servicenetworking.googleapis.com",
]

# Network variables
vpc_name = "vpc-1"
vpc_cidr = "10.0.0.0/16"

subnet_zones                         = ["us-east1-b"]
subnet_public_zone                   = "us-east1-b"
subnet_public_zone_prefix            = "public"
subnet_flow_log_aggregation_interval = "INTERVAL_30_SEC"

tool_server_name      = "tool-server"
tool_server_disk_size = 30
tool_server_packages  = ["wget", "tmux"]

cloud_nat_router_name = "cloud-nat-router"

k8s_cp_server_name = "control-plane"
k8s_cp_disk_size   = 80

k8s_worker_server_name = "worker-node"
k8s_worker_disk_size   = 80

