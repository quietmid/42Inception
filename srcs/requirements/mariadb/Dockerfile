FROM alpine:3.20.6

RUN apk update && apk add --no-cache mariadb mariadb-client \
	mariadb-server-utils \
	&& mkdir -p /var/lib/mysql /var/log/mysql /run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/log/mysql /run/mysqld \
	&& mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./conf/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

COPY ./tools/conf_db.sh /usr/local/bin/conf_db.sh

RUN chmod +x /usr/local/bin/conf_db.sh
# RUN chmod 644 /etc/my.cnf.d/mariadb.cnf

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/conf_db.sh" ]