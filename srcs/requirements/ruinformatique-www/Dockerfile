FROM alpine:3.20.6 AS builder

RUN apk add git npm

WORKDIR /app

RUN git clone https://github.com/rpdjf/ruinformatique-www.git

WORKDIR /app/ruinformatique-www

RUN npm install

RUN npm run build

FROM alpine:3.20.6

WORKDIR /var/www/ruinformatique

COPY --from=builder /app/ruinformatique-www/src/ /var/www/ruinformatique/
