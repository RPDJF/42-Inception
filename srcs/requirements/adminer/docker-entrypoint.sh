#!/bin/sh
chown -R www:www /var/www/adminer

echo Starting adminer...
php-fpm83 -F