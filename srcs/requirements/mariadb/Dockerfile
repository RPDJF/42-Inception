FROM alpine:3.21.3

EXPOSE 3306

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

RUN sed -i '/skip-networking/d' /etc/my.cnf.d/mariadb-server.cnf

ENTRYPOINT	sh -c "mariadbd --user=mysql & \
			sleep 5 && \
			mariadb -u root -e \"ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;\" && \
			mariadb -u root -p${MYSQL_ROOT_PASSWORD} -e \"CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%'; FLUSH PRIVILEGES;\" && \
			tail -f /dev/null"
