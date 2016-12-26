#!/bin/bash
if [ ! -f /var/lib/mysql/ibdata1 ]; then
   mysql_install_db
fi
/usr/bin/mysqld_safe &
sleep 10s
sed -i "s/@MYSQL_ROOT_PASSWORD@/$MYSQL_ROOT_PASSWORD/" /opt/sql/init.sql
echo "running init.sql"
echo "OK if this fails"
mysql < /opt/sql/init.sql
killall mysqld
sleep 5s
/usr/bin/mysqld_safe &
while [ 1 ]; do sleep 2; done
