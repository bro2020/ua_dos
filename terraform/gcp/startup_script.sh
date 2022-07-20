#!/bin/bash
#
#   Used in Terraform
#
#   variable "vpns" {
#     type = map(any)
#     default = {
#       "vpn1" = {
#         VPN_SERVER_NAME = "vpn1"
#         VPN_HOST        = "1.2.3.4"
#         VPN_LOGIN       = "admin"
#         VPN_PASSWORD    = "admin"
#       }
#     }
#   }
#   
#   locals {
#     gcpname  = "gcp-node[count.index +1]"
#     data_script = flatten([
#       for data in var.vpns : {
#         vpn_name = data.VPN_SERVER_NAME
#         vpn_host = data.VPN_HOST
#         vpn_login = data.VPN_LOGIN
#         vpn_pass = data.VPN_PASSWORD
#       }
#     ])

export PREIP="$(ip route | head -n1 | cut -d' ' -f3 | cut -d'.' -f1-3)"
export SUBNT="$PREIP.0/24"
export PARNT=$(ip route | head -n1 | cut -d' ' -f5)
sudo apt update && \
sudo apt install net-tools htop iftop docker.io -y &>/dev/null && \
#sudo docker pull bro2020/ua_dos:latest &>/dev/null && \
sudo docker network create -d ipvlan --subnet=${SUBNT} -o parent=${PARNT} gwnet && \
sudo docker run --privileged --net=gwnet --name local.gcpname --hostname local.gcpname --ip "${PREIP}"."${count.index +2}" -e VPN_SERVER_NAME=local.data_script[count.index].vpn_name -e VPN_HOST=local.data_script[count.index].vpn_host -e VPN_LOGIN=local.data_script[count.index].vpn_login -e VPN_PASSWORD=local.data_script[count.index].vpn_pass -d bro2020/ua_dos:latest
