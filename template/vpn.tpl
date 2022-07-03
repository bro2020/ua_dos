pty "/usr/sbin/pptp ${VPN_HOST} --loglevel 0 --nolaunchpppd"
lock
noauth
nobsdcomp
nodeflate
name ${VPN_LOGIN} 
remotename ${VPN_SERVER_NAME}
ipparam ${VPN_SERVER_NAME}
persist
maxfail 0
holdoff 10
