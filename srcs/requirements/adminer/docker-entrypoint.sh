#!/bin/sh
chown -R www:www /var/www/adminer

echo Starting adminer...
exec php-fpm83 -F