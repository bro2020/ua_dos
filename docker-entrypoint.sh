#!/bin/bash

export VPN_SERVER_NAME=${VPN_SERVER_NAME}
export VPN_HOST=${VPN_HOST}
export VPN_LOGIN=${VPN_LOGIN}
export VPN_PASSWORD=${VPN_PASSWORD}

/etc/init.d/ssh start

vpn_file=$(sed "s/\${VPN_SERVER_NAME}/${VPN_SERVER_NAME}/;s/\${VPN_HOST}/${VPN_HOST}/;s/\${VPN_LOGIN}/${VPN_LOGIN}/;s/\${VPN_PASSWORD}/${VPN_PASSWORD}/g" vpn.tpl)
chap_file=$(sed "s/\${VPN_SERVER_NAME}/${VPN_SERVER_NAME}/;s/\${VPN_LOGIN}/${VPN_LOGIN}/;s/\${VPN_PASSWORD}/${VPN_PASSWORD}/g" chap-secrets.tpl)

echo "$vpn_file" > /etc/ppp/peers/${VPN_SERVER_NAME}
echo "$chap_file" > /etc/ppp/chap-secrets

echo "VPN_SERVER_NAME=${VPN_SERVER_NAME}
VPN_HOST=${VPN_HOST}
VPN_LOGIN=${VPN_LOGIN}
VPN_PASSWORD=${VPN_PASSWORD}"

con_to_vpn(){
pon ${VPN_SERVER_NAME}
sleep 5
check_and_start
}

check_and_start(){
if [[ "$(ifconfig | grep ppp0)" != '' ]]; then
echo "Connection to $VNUM completed successfully :)"
#/opt/checker.sh &
/opt/db1000n
else
echo 'VPN not worked :('
sleep 1000
#exit 1
fi
}

con_to_vpn