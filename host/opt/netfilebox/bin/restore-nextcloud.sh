#!/bin/bash
. /opt/netfilebox/bin/setenv
rm -f /opt/netfilebox/data/web/nextcloud/config/config.php
docker exec web /opt/db/bin/db.sh 'drop database nextcloud'
docker exec web /opt/db/bin/db.sh 'create database nextcloud'
cd /opt/netfilebox
docker-compose stop web
docker-compose rm -f nextcloud
touch /opt/netfilebox/events/mail_up
docker-compose up -d web
