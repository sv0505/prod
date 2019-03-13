#!/usr/bin/env bash

# install
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y unzip
sudo apt-get install -y nginx
sudo npm install -g pm2

# api
sudo useradd wwwapi
sudo git clone https://github.com/stmichaelmontreal/api.git /var/www/api
sudo npm install --prefix /var/www/api --production
sudo find /var/www/api/fdb/ -exec chown wwwapi: {} \;

# pm2
pm2 start /var/www/api/server.js
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u wwwapi --hp /home/wwwapi

# nginx
sudo systemctl stop nginx
sudo cp nginx-default /etc/nginx/sites-enabled/default

# web client
git clone https://github.com/stmichaelmontreal/deploy.git
cd deploy
bash git-to-web.sh