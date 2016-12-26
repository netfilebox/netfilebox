#!bin/bash
if [ -z "$EXTERNAL_IP" ]; then
   echo >&2 ' ERROR: set -e EXTERNAL_IP='
   exit 1
fi
if [ -z "$FQDN" ]; then
   echo >&2 ' ERROR: set -e FQDN='
   exit 1
fi

#macro replace in shared, gets overridden for each run 
sed -i "s/@MYSQL_ROOT_PASSWORD@/$MYSQL_ROOT_PASSWORD/" /opt/share/autoconfig.php

#copy persistent mount 
cp /opt/share/autoconfig.php /opt/www/nextcloud/config

chown www-data:www-data /opt/www/nextcloud -R
chown www-data:www-data /opt/nextcloud/data -R
