WORDPRESS_URL=rude-jes.42.fr
STATIC_URL=ruinformatique-www
BONUS_URL=qbittorrent

# adding temporary dns
(cat /etc/hosts | grep $WORDPRESS_URL) > /dev/null || echo "127.0.0.1 $WORDPRESS_URL" | sudo tee -a /etc/hosts > /dev/null
(cat /etc/hosts | grep $STATIC_URL) > /dev/null || echo "127.0.0.1 $STATIC_URL" | sudo tee -a /etc/hosts > /dev/null
(cat /etc/hosts | grep $BONUS_URL) > /dev/null || echo "127.0.0.1 $BONUS_URL" | sudo tee -a /etc/hosts > /dev/null

# use .env.example as .env
echo Generating generic .env file...
cp srcs/.env.example srcs/.env

# generate ssl cert for nginx
echo Generating SSL certificates...
mkdir -p srcs/requirements/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout srcs/requirements/nginx/ssl/$WORDPRESS_URL.key \
  -out srcs/requirements/nginx/ssl/$WORDPRESS_URL.crt \
  -subj "/C=CH/ST=Lausanne/L=Lausanne/O=42/CN=$WORDPRESS_URL" 2> /dev/null

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout srcs/requirements/nginx/ssl/$STATIC_URL.key \
  -out srcs/requirements/nginx/ssl/$STATIC_URL.crt \
  -subj "/C=CH/ST=Lausanne/L=Lausanne/O=42/CN=$STATIC_URL" 2> /dev/null

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout srcs/requirements/nginx/ssl/$BONUS_URL.key \
  -out srcs/requirements/nginx/ssl/$BONUS_URL.crt \
  -subj "/C=CH/ST=Lausanne/L=Lausanne/O=42/CN=$BONUS_URL" 2> /dev/null

echo Changing certificates permissions...
chmod 644 srcs/requirements/nginx/ssl/*.crt
chmod 600 srcs/requirements/nginx/ssl/*.key