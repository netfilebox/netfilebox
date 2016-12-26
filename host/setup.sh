#!/bin/bash
FQDN=localhost

cp ./opt / -r
cp ./etc / -r
# centos specific /etc
cp ./centos/etc / -r

#enable public key access only
systemctl restart sshd
systemctl enable netfilebox

sed -i "s/@FQDN@/$FQDN/" /etc/hostname
sed -i "s/@FQDN@/$FQDN/" /etc/hosts

mkdir /opt/netfilebox/logs

# default ssl certificate
mkdir -p /opt/netfilebox/data/ssl
cd /opt/netfilebox/data/ssl
ln -s self-signed/netfilebox.crt 
ln -s self-signed/netfilebox.key

