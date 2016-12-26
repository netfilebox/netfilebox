#!/bin/bash
docker pull netfilebox/db
docker pull netfilebox/web
docker pull netfilebox/nextcloud
docker rmi $(docker images|grep none|awk '{print $3}')
