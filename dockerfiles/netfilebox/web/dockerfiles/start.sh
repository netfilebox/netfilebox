#!bin/bash
. /opt/db/bin/db-avail.sh

sed -i "s/@FQDN@/$FQDN/" /etc/nginx/sites-enabled/netfilebox.conf

while [ ! -f "/opt/ssl/netfilebox.crt" ]
do
   echo "Waiting for SSL keys..."
   sleep 5s
done
echo "SSL keys are available"

chown www-data:www-data /opt/www -R

php5-fpm
nginx &
while [ 1 ]; do sleep 2; done
