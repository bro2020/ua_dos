#!/bin/bash
sleep 5

worker() {
if [[ "$(ps -d | grep pptp)" = '' ]];then
pkill db1000n
else
exit 0
fi
cykler
}

cykler() {
sleep 30
worker
}

cykler