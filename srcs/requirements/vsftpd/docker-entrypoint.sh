#!/bin/sh

adduser -D -g "$FTP_USER" -h /var/www/wordpress $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf