#!/bin/bash
if [[ "$(ps -d | grep pptp)" = '' ]];then
pkill db1000n
else
exit 0
fi
