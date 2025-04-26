#!/bin/sh
chown -R www:www /var/www/wordpress

while ! mysql -u ${MYSQL_USER} -h ${MYSQL_HOST} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

echo Installing redis-cache plugin...
wp plugin install redis-cache --activate
wp redis enable

echo Starting wordpress...
php-fpm83 -F