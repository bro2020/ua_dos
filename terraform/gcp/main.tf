locals {
  gcpname = "gcp-node[count.index +1]"
  data_script = flatten([
    for data in var.vpns : {
      vpn_name  = data.VPN_SERVER_NAME
      vpn_host  = data.VPN_HOST
      vpn_login = data.VPN_LOGIN
      vpn_pass  = data.VPN_PASSWORD
    }
  ])
}

#/*
resource "google_compute_instance" "ua_dos_nodes" {
  count        = length(var.node_var.type_instance)
  provider     = google.Frankfurt
  name         = "ua-dos-gcp-node${count.index + 1}"
  machine_type = element(var.node_var.type_instance, count.index)
  boot_disk {
    initialize_params {
      image = element(var.node_var.distr, count.index)
    }
  }

  tags = ["ua-dos-node${count.index + 1}"]

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
  metadata = {
    "ssh-keys" = "${var.ssh_var.ssh_user}:${file(var.ssh_var.ssh_pub_key)}"
  }
  #  metadata_startup_script = "startup_script.sh"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.ssh_var.ssh_user
      private_key = file(var.ssh_var.ssh_priv_key)
      host        = self.network_interface[0].access_config.0.nat_ip
    }

    script = "startup_script.sh"
  }

}
#*/


output "external-ip" {
  value = {
    for i in google_compute_instance.ua_dos_nodes : i.name => i.network_interface[0].access_config.0.nat_ip
  }
}

output "node-type" {
  value = {
    for i in google_compute_instance.ua_dos_nodes : i.name => i.machine_type
  }
}
