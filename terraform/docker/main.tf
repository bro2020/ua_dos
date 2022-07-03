variable "vpns" {
  type = map(any)
  default = {
    "vpn1" = {
      VPN_SERVER_NAME  = "vpn1"
      VPN_VPN_HOST     = "0.0.0.0",
      VPN_VPN_LOGIN    = "adminu",
      VPN_VPN_PASSWORD = "adminu",
      LocalIP          = "192.168.0.2"
    }
    "vpn2" = {
      VPN_SERVER_NAME = "vpn2"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.3"
    }
    "vpn3" = {
      VPN_SERVER_NAME = "vpn3"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.4"
    }
    "vpn4" = {
      VPN_SERVER_NAME = "vpn4"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.5"
    }
    "vpn5" = {
      VPN_SERVER_NAME = "vpn5"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.6"
    }
    "vpn6" = {
      VPN_SERVER_NAME = "vpn6"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.7"
    }
    "vpn7" = {
      VPN_SERVER_NAME = "vpn7"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.8"
    }
    "vpn8" = {
      VPN_SERVER_NAME = "vpn8"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.9"
    }
    "vpn9" = {
      VPN_SERVER_NAME = "vpn9"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.10"
    }
    "vpn10" = {
      VPN_SERVER_NAME = "vpn10"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.0.11"
    }
  }
}



resource "docker_network" "gwnet" {
  name   = "gwnet"
  driver = "ipvlan"
  ipam_config {
    gateway  = "192.168.1.1"
    subnet   = "192.168.1.0/24"
    ip_range = "192.168.1.2-192.168.1.11"
  }
  options = {
    parent = "wlo1"
  }
}

resource "docker_image" "ua_dos" {
  name = "ua_dos"
  build {
    path         = "../../."
    tag          = ["ua_dos:latest"]
    force_remove = true
  }
  depends_on = [
    docker_network.gwnet
  ]
}

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
  hostname = "nb_node"
  env = {
    VPN_SERVER_NAME = each.value.VPN_SERVER_NAME
    VPN_VPN_HOST = each.value.VPN_VPN_HOST
    VPN_LOGIN = each.value.VPN_LOGIN
    VPN_PASSWORD = each.value.VPN_PASSWORD
  }
  depends_on = [
    docker_image.ua_dos,
    docker_network.gwnet
  ]

}
