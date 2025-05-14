#!/bin/sh

#make the script exit immediately if commands fail
set -e

echo "--- MariaDB initialization ---"
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#  	echo "--- Initializing MariaDB system tables ---"
mysqld --user=mysql --bootstrap <<EOF
	USE mysql;
	FLUSH PRIVILEGES;

	DELETE FROM mysql.user WHERE User='';
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN('localhost');
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PWD}';
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PWD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;
EOF
# else
# 	echo "--- MariaDB is already initialized ---"
# fi

echo "--- Starting MariaDB server ---"
exec mysqld_safe --user=mysql