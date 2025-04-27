FROM alpine:3.20.6

EXPOSE 80 443

RUN apk update && apk add nginx openssl

RUN adduser -D -g 'www' www

RUN mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www

RUN sed -i 's|access_log /var/log/nginx/access.log main;|access_log /dev/stdout main;|' /etc/nginx/nginx.conf
RUN sed -i 's|error_log /var/log/nginx/access.log warn;|access_log /dev/stderr warn;|' /etc/nginx/nginx.conf

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]