FROM alpine:3.20.6

EXPOSE 8080

RUN apk update && apk add qbittorrent-nox

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]