#!/bin/bash
sleep 5

worker() {
if [[ "$(ifconfig | grep ppp0)" != '' ]];then
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