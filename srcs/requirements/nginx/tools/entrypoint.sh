#!/bin/bash

openssl req -x509 -newkey rsa:4096 \
			-keyout /etc/ssl/private/server.key \
			-out /etc/ssl/certs/server.crt -days 365 -nodes \
			-subj "/C=FI/ST=Uusima/L=Helsinki/O=Hive Helsinki/CN=${DOMAIN_NAME}"

echo "Starting NGINX"
exec nginx -g "daemon off;"