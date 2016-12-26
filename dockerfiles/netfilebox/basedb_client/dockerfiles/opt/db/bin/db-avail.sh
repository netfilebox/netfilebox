#!/bin/bash
STATUS=$(mysql -uroot -p$MYSQL_ROOT_PASSWORD -h db -e "status" 2>&1|awk {'print $1'})
while [[ $STATUS == "ERROR" ]] 
do
   echo "waiting for DB to become available..."
   sleep 5s
   STATUS=$(mysql -uroot -p$MYSQL_ROOT_PASSWORD -h db -e "status" 2>&1|awk {'print $1'})
done
echo "DB is available"
