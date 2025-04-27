FROM alpine:3.20.6

EXPOSE 21

RUN apk update && apk add vsftpd

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]
