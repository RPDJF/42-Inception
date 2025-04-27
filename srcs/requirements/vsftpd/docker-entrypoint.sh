#!/bin/sh

adduser -D -g "$FTP_USER" -h /var/www/wordpress $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

exec vsftpd /etc/vsftpd/vsftpd.conf