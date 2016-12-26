#!/bin/bash
UPTIME=$(mysql -uroot -p$MYSQL_ROOT_PASSWORD -e 'status' |grep Uptime)
if [[ $UPTIME == Uptime* ]]; then
   exit 0
fi
exit 1
