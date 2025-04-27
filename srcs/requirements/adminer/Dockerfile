FROM alpine:3.20.6

RUN apk update && apk add mysql-client libcrypto3 libssl3 php83 php83-common php83-fpm php83-opcache php83-mysqlnd php83-mysqli php83-pdo_mysql curl less php83-phar php83-mbstring php83-session


WORKDIR /var/www/adminer
RUN curl https://www.adminer.org/static/download/5.2.1/adminer-5.2.1.php --output index.php

RUN adduser -D -g 'www' www

RUN chown -R www:www /var/www/adminer

EXPOSE 9000

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]