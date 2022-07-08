provider "google" {
  project     = var.project_id
  region      = var.zones
  credentials = file("./keys/*.json")
}