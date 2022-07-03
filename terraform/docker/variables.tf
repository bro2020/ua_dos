variable "vpns" {
  type = map(any)
  default = {
    "vpn1" = {
      VPN_SERVER_NAME  = "vpn1"
      VPN_HOST     = "pusyrouter.asuscomm.com",
      VPN_LOGIN    = "adminu",
      VPN_PASSWORD = "adminu",
      LocalIP          = "192.168.1.2"
    }
    "vpn2" = {
      VPN_SERVER_NAME = "vpn2"
      VPN_HOST        = "176.62.178.248",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.1.3"
    }
    "vpn3" = {
      VPN_SERVER_NAME = "vpn3"
      VPN_HOST        = "uasupport.asuscomm.com",
      VPN_LOGIN       = "adminr",
      VPN_PASSWORD    = "adminr",
      LocalIP         = "192.168.1.4"
    }
 /*   "vpn4" = {
      VPN_SERVER_NAME = "vpn4"
      VPN_HOST        = "stoprussia2022.asuscomm.com",
      VPN_LOGIN       = "adminr",
      VPN_PASSWORD    = "adminr",
      LocalIP         = "192.168.1.5"
    }
    "vpn5" = {
      VPN_SERVER_NAME = "vpn5"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.1.6"
    }
    "vpn6" = {
      VPN_SERVER_NAME = "vpn6"
      VPN_HOST        = "supportua.asuscomm.com",
      VPN_LOGIN       = "adminr",
      VPN_PASSWORD    = "adminr",
      LocalIP         = "192.168.1.7"
    }
    "vpn7" = {
      VPN_SERVER_NAME = "vpn7"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.1.8"
    }
    "vpn8" = {
      VPN_SERVER_NAME = "vpn8"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.1.9"
    }
    "vpn9" = {
      VPN_SERVER_NAME = "vpn9"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.1.10"
    }
    "vpn10" = {
      VPN_SERVER_NAME = "vpn10"
      VPN_HOST        = "0.0.0.0",
      VPN_LOGIN       = "adminu",
      VPN_PASSWORD    = "adminu",
      LocalIP         = "192.168.1.11"
   }
*/ }
}