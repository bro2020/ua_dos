#/*
resource "docker_network" "gwnet" {
  name   = "gwnet"
  driver = "ipvlan"
  ipam_config {
    gateway  = var.gw
    subnet   = var.subnt
  }
  options = {
    parent = "wlo1"
  }
}
#/*
resource "docker_image" "ua_dos" {
  name = "ua_dos"
  build {
    path         = "../../."
    tag          = ["ua_dos:${var.ver}"]
    force_remove = true
  }
  depends_on = [
    docker_network.gwnet
  ]
}

#/*
resource "docker_container" "ua_dos_container" {
  for_each   = var.vpns
  name       = "nb_node_${each.key}"
  image      = docker_image.ua_dos.name
  restart    = "unless-stopped"
  privileged = true
  networks_advanced {
    name         = "gwnet"
    ipv4_address = each.value.LocalIP
  }
  hostname = "nb_node_${each.key}"
  env = [
    "VPN_SERVER_NAME=${each.value.VPN_SERVER_NAME}",
    "VPN_HOST=${each.value.VPN_HOST}",
    "VPN_LOGIN=${each.value.VPN_LOGIN}",
    "VPN_PASSWORD=${each.value.VPN_PASSWORD}"
  ]
  depends_on = [
    docker_image.ua_dos,
    docker_network.gwnet
  ]

}
#*/
