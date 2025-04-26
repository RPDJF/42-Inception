# adding temporary dns
(cat /etc/hosts | grep rude-jes.42.fr) || echo "127.0.0.1 rude-jes.42.fr" | sudo tee -a /etc/hosts > /dev/null

# use .env.example as .env
echo Generating generic .env file...
cp srcs/.env.example srcs/.env

# generate ssl cert for nginx
echo Generating SSL certificates...
mkdir -p srcs/requirements/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout srcs/requirements/nginx/ssl/rude-jes.42.fr.key \
  -out srcs/requirements/nginx/ssl/rude-jes.42.fr.crt \
  -subj "/C=CH/ST=Lausanne/L=Lausanne/O=42/CN=rude-jes.42.fr" 2> /dev/null
echo Changing certificates permissions...
chmod 644 srcs/requirements/nginx/ssl/rude-jes.42.fr.crt
chmod 600 srcs/requirements/nginx/ssl/rude-jes.42.fr.key