#!/bin/bash
OUTDIR=/opt/ssl/self-signed
mkdir $OUTDIR
chmod 700 $OUTDIR 
chmod g+s $OUTDIR
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout $OUTDIR/netfilebox.key -out $OUTDIR/netfilebox.crt
chown www-data:www-data $OUTDIR -R
