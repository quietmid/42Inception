#!/bin/sh

set -e
# -e if a command fails, the script stop
/usr/local/bin/wp-install.sh

echo "Starting PHP-FPM..."
# -F foreground mode. php is a specific implementation of PHP that's optimized for web serv
exec php-fpm83 -F
