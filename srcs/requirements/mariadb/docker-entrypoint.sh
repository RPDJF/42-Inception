#!/bin/bash
echo "Starting MariaDB..."
mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null 2> /dev/null
mariadbd --user=mysql &
sleep 5

# Check if the database exists
DB_EXISTS=$(mariadb -u root -p${MYSQL_ROOT_PASSWORD} -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" | grep "${MYSQL_DATABASE}")

if [ -z "$DB_EXISTS" ]; then
  echo "Database ${MYSQL_DATABASE} does not exist. Proceeding with configuration..."
  mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
  mariadb -u root -p${MYSQL_ROOT_PASSWORD} -e "
    CREATE DATABASE ${MYSQL_DATABASE};
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;"
fi

tail -f /dev/null