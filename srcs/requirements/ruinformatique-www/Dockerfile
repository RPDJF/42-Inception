FROM alpine:3.21.3

RUN apk add git npm

WORKDIR /app

RUN git clone https://github.com/rpdjf/ruinformatique-www.git

WORKDIR /app/ruinformatique-www

RUN npm install

RUN npm run build

RUN mkdir -p /var/www/

RUN mv src /var/www/ruinformatique