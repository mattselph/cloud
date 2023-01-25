variable "project" {
  type        = string
  description = "project id"
}

variable "state_bucket_name" {
  type = string
}

variable "state_bucket_location" {
  type    = string
  default = "US"
}

variable "state_bucket_prefix" {
  type = string
}
