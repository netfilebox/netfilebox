#!/bin/bash
. /opt/netfilebox/bin/setenv
cd /opt/netfilebox
docker-compose stop

# update
yum update -y > /opt/netfilebox/logs/system-update.log

docker rm $(docker ps -a|awk '{print $1}')
docker rmi $(docker images|grep none|awk '{print $3}')
/opt/netfilebox/bin/pull-images.sh
cd /opt/netfilebox && docker-compose up -d 
