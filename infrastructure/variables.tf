variable "project" {
  type        = string
  description = "project id"
}

variable "api" {
  type        = list(string)
  description = "list of APIs to enable in this project"
}

variable "vpc_name" {
  type    = string
  default = "vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "cidr of the vpc, subnets created will be based on this value"
  default     = "10.0.0.0/8"
}

variable "subnet_zones" {
  type        = list(string)
  description = "list of zones in which to create subnets"
}

variable "subnet_public_zone" {
  type        = string
  description = "zone of the public subnet"
}

variable "subnet_public_zone_prefix" {
  type        = string
  description = "label prefix  of the public subnet"
}

variable "subnet_flow_log_aggregation_interval" {
  type        = string
  description = "interval per connection when logs are collected"
  default     = "INTERVAL_10_MIN"
}

variable "subnet_flow_log_sample_rate" {
  type    = number
  default = 0.5
}

variable "subnet_flow_log_metadata_captured" {
  type    = string
  default = "INCLUDE_ALL_METADATA"
}

variable "tool_server_name" {
  type = string
}

variable "tool_server_machine_type" {
  type    = string
  default = "e2-micro"
}

variable "tool_server_disk_size" {
  type = number
}

variable "tool_server_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "tool_server_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "cloud_nat_router_name" {
  type = string
}

variable "k8s_cp_server_name" {
  type = string
}

variable "k8s_cp_machine_type" {
  type    = string
  default = "e2-medium"
}

variable "k8s_cp_disk_size" {
  type = number
}

variable "k8s_cp_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "k8s_cp_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "k8s_worker_server_name" {
  type = string
}

variable "k8s_worker_machine_type" {
  type    = string
  default = "e2-medium"
}

variable "k8s_worker_disk_size" {
  type = number
}

variable "k8s_worker_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "k8s_worker_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "tool_server_packages" {
  type        = list(string)
  description = "packages to install on the tool server"
}

