#!/usr/bin/env bash

cd /var/www/api
sudo git pull origin master
sudo rm -rf /var/www/api/node_modules
npm install --production
cd fdb
sudo bash folders.sh
sudo su -c "pm2 restart 0" -s /bin/sh wwwapi
