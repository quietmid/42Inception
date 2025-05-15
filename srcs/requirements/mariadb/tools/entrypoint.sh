#!/bin/sh

set -e

mysqld --user=mysql --bootstrap <<EOF
	USE mysql;
	FLUSH PRIVILEGES;

	DELETE FROM mysql.user WHERE User='';
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN('localhost');
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;
EOF

echo "Starting MariaDB..."
exec mysqld_safe --user=mysql
