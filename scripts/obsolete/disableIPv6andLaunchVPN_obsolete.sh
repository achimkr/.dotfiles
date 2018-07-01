#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo "Run as root"
    exit
fi

sysctl net/ipv6/conf/all/disable_ipv6=1
openvpn /etc/openvpn/client/-443.ovpn
sysctl net/ipv6/conf/all/disable_ipv6=0
