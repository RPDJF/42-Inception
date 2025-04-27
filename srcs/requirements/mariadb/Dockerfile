FROM alpine:3.20.6

EXPOSE 3306

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN sed -i '/skip-networking/d' /etc/my.cnf.d/mariadb-server.cnf

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]
