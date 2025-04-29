FROM alpine:3.20.6

RUN apk update && apk add mysql-client libcrypto3 libssl3 php83 php83-common php83-fpm php83-opcache php83-mysqlnd php83-mysqli php83-pdo_mysql curl less php83-phar php83-mbstring

# go back to wordpress
WORKDIR /var/www/wordpress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

RUN adduser -D -g 'www' www

RUN chown -R www:www /var/www/wordpress

# install wp cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv ./wp-cli.phar /usr/local/bin/wp

COPY ./php-fpm.conf /etc/php83/php-fpm.conf

EXPOSE 9000

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]