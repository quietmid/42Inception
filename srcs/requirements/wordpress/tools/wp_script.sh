#!/bin/sh
echo "entered wordpress script"
# Exit on any error
set -e

MAX_RETRIES=30
RETRY_COUNT=0
# Wait for MariaDB to be ready
# echo "Waiting for MariaDB..."
# until mysqladmin ping -h mariadb -u $MYSQL_USER --password=$MYSQL_PWD --silent; do
#     if ["$RETRY_COUNT" -ge "$MAX_RETRIES"]; then
#         echo "MariaDB didn't respond after $MAX_RETRIES attempts. Exiting..."
#         exit 1
#     fi
#     echo "Waiting for MariaDB.. in loop"
#     sleep 2
# done

# set up database connection and admin user
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PWD" \
		--dbhost="$MYSQL_HOST" \
		--path=/var/www/wordpress/ \
		--allow-root

    wp core install \
    	--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root
fi

# create wordpress user
if ! wp user get "$WP_USER" --field=user_login --allow-root > /dev/null 2>&1; then
    wp user create "$WP_USER" "$WP_EMAIL" --role=author --user_pass="$WP_PWD" --allow-root
fi

echo "Starting PHP-FPM..."
exec php-fpm83 -F