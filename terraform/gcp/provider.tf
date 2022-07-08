provider "google" {
  project     = var.alias_prov.Frankfurt.project_id
  region      = var.alias_prov.Frankfurt.regs
  zone        = var.alias_prov.Frankfurt.zones
  credentials = file("${var.alias_prov.Frankfurt.cred}")
  alias = "Frankfurt"
}
