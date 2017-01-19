#!/bin/bash
sudo ./setup.sh
sed -i "s/: netfilebox\//: netfilebox_/" /opt/netfilebox/docker-compose.yml
sed -i "s/^\/opt\/netfilebox/#\/opt\/netfilebox/" /opt/netfilebox/bin/boot.sh
exit
