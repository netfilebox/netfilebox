#!/bin/bash
if [ -z "$1" ]
then
  mysql -hdb -uroot -p$MYSQL_ROOT_PASSWORD
else
  mysql -hdb -uroot -p$MYSQL_ROOT_PASSWORD -e "$@"
fi
