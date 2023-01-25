resource "google_project_service" "enable_api" {
  for_each = toset(var.api)

  project = var.project
  service = each.value
}
