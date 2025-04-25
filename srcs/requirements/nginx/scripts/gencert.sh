#!/bin/sh

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/rude-jes.42.fr.key \
  -out /etc/nginx/ssl/rude-jes.42.fr.crt \
  -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=rude-jes.42.fr" 2> /dev/null

chmod 644 /etc/nginx/ssl/rude-jes.42.fr.crt
chmod 600 /etc/nginx/ssl/rude-jes.42.fr.key
chown www:www /etc/nginx/ssl/rude-jes.*


/bin/sh ./docker-entrypoint.sh "$@"