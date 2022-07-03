#!/bin/bash
VNUM=$1
export VPN_SERVER_NAME=$P{VPN_SERVER_NAME}
export VPN_HOST=${VPN_HOST}
export VPN_LOGIN=${VPN_LOGIN}
export VPN_PASSWORD=${VPN_PASSWORD}

/etc/init.d/ssh start

mv -f vpn.tpl /etc/ppp/peers/ && \
mv -f chap-secrets.tpl /etc/ppp/ && \

con(){
echo "VNUM=$VNUM"
pon ${VNUM}
sleep 5
check
}

check(){
if [[ "$(ifconfig | grep ppp0)" != '' ]]; then
echo "Connection to $VNUM completed successfully :)"
/opt/checker.sh &
/opt/db1000n
else
echo 'VPN not worked :('
exit 1
fi
}

con