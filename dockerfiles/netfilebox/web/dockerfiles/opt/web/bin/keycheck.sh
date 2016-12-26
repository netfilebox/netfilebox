#!/bin/bash

SELF_SIGNED_DIR=/opt/ssl/self-signed
KEYFILE=$SELF_SIGNED_DIR/netfilebox.key
CERTFILE=$SELF_SIGNED_DIR/netfilebox.crt

# generate ssl keys if needed 
if [ ! -f "$CERTFILE" ]
then
   echo "Generating SSL keys..."
   /opt/web/bin/genkey-nginx.sh &
fi
while [ ! -f "$CERTFILE" ]
do
   sleep 5s
done
# create symlink to key if needed
if [ ! -f /opt/ssl/netfilebox.crt ]; then
   echo "Using self-signed certificate"
   ln -s $CERTFILE /opt/ssl
   ln -s $KEYFILE /opt/ssl
fi
echo "SSL keys are available"
