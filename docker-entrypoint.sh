#!/bin/bash
VNUM=$1

/etc/init.d/ssh start
/etc/init.d/cron start

con(){
echo "VNUM=$VNUM"
pon ${VNUM}
sleep 4
check
}

check(){
if [[ "$(ifconfig | grep ppp0)" != '' ]]; then
echo "Connection to $VNUM completed successfully :)"
/opt/db1000n
else
echo 'VPN not worked :('
exit 1
fi
}

con