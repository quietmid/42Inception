FROM alpine:3.20.6

# install the required php extension for WordPress
# - php83: PHP 8.3, basic php package
# - php83-fpm: PHP-FPM, FastCGI Process Manager for PHP, matches my www.cnf configuration
# - php83-phar: PHP Archive, PHP Archive, handles .phar files
# - php83-curl: cURL, PHP extension for cURL
# - php83-mysqli: MySQLi, PHP extension for MySQL, required for mariaDB connection
# - php83-iconv: iconv, PHP extension for iconv, charcater encode, different character encoding
# - php83-json: JSON, PHP extension for JSON, handles JSON data
# - php83-xml: provides support for working with XML (Extensible Markup Language) in PHP.
# - php83-mbstring: provides support for multibyte string functions in PHP.

RUN apk update && apk add --no-cache php83 \
	php83-fpm \
	php83-phar \
	php83-curl \
	php83-mysqli \
	php83-iconv \
	php83-json \
	php83-xml \
	php83-mbstring \
	curl

RUN mkdir -p /var/www/wordpress
WORKDIR /var/www/wordpress

# this block runs the cmd that downloads the wp command line interface
# set the PHP memory limit and add user/groups and set permissions
RUN curl -sSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp \
	&& php -d memory_limit=512M /usr/local/bin/wp core download --allow-root \
	&& addgroup -S nginx \
	&& adduser -S -G nginx -g nginx nginx \
	&& chown -R nginx:nginx /var/www/wordpress \
	&& chmod -R 755 /var/www/wordpress

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY ./tools/ /usr/local/bin/

RUN chmod +x /usr/local/bin/*

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/wp_script.sh" ]
