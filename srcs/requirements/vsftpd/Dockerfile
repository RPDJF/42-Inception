FROM alpine:3.21.3

EXPOSE 21

RUN apk update && apk add vsftpd

RUN cat <<EOF > /etc/vsftpd/vsftpd.conf
listen=YES
listen_ipv6=NO

seccomp_sandbox=NO
chroot_local_user=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_root=/var/www/

xferlog_enable=YES
xferlog_file=/dev/stdout
log_ftp_protocol=YES

EOF

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]
