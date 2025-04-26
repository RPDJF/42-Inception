FROM alpine:3.21.3

RUN apk add redis

COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]