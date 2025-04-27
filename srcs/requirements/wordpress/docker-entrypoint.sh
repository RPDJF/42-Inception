#!/bin/sh
chown -R www:www /var/www/wordpress

while ! mysql -u ${MYSQL_USER} -h ${MYSQL_HOST} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

if [ -e /var/www/wordpress/wp-config-sample.php ]; then
	echo installing wordpress...
    wp core install --url=$WORDPRESS_DOMAIN/ \
                        --title=$WORDPRESS_TITLE\
                        --admin_user=$WORDPRESS_ADMIN_USER\
                        --admin_password=$WORDPRESS_ADMIN_PASSWORD\
                        --admin_email=$WORDPRESS_ADMIN_EMAIL\
                        --skip-email\
                        --allow-root
    wp user create    $WORDPRESS_USER\
                        $WORDPRESS_EMAIL\
                        --user_pass=$WORDPRESS_PASSWORD\
                        --role=author\
                        --allow-root
	echo Installing redis-cache plugin...
	wp plugin install redis-cache --activate
	wp redis enable
	rm /var/www/wordpress/wp-config-sample.php
fi

echo Starting wordpress...
php-fpm83 -F