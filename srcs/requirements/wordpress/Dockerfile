FROM alpine:3.21.3

EXPOSE 80

RUN apk update && apk add php83 php83-fpm php83-opcache curl

RUN ln -s /etc/php/ /etc/php83/

RUN mkdir -p /run/php

WORKDIR /var/www/wordpress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

EXPOSE 9000

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]