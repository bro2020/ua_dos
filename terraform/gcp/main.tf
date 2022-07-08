#/*
resource "google_compute_instance" "ua_dos_nodes" {
  count        = length(var.node_var.type_instance)
  provider     = google.Frankfurt
  name         = "ua-dos-gcp-node${count.index +1}"
  machine_type = element(var.node_var.type_instance, count.index)
  boot_disk {
    initialize_params {
      image = element(var.node_var.distr, count.index)
    }
  }

  tags = ["ua-dos-node${count.index +1}"]

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
  metadata = {
    "ssh-keys" = "${element(var.node_var.ssh_users, count.index)}:${file(element(var.node_var.ssh_key_files, count.index))}"
  }
}
#*/

output "external-ip" {
  value = {
  for i in google_compute_instance.ua_dos_nodes : i.name => i.network_interface[0].access_config.0.nat_ip
  }
}
