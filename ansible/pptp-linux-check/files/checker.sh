#!/bin/bash
sleep 5

worker() {
if [[ "$(ps -d | grep pptp)" = '' ]];then
pkill db1000n
else
cykler
fi
}

cykler() {
sleep 30
worker
}

cykler