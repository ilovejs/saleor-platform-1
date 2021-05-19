#!/bin/sh

# copy nginx conf
scp -r ./saleor-dashboard/nginx/default.conf     root@194.195.252.175:/etc/nginx/sites-available/dashboard
scp -r ./saleor-storefront/nginx/default.conf    root@194.195.252.175:/etc/nginx/sites-available/store

# copy src files
ssh root@194.195.252.175 'rm /var/www/dashboard.tuner.games/*'
cd saleor-dashboard
yarn clean
yarn build
scp -r ./build/dashboard/*     root@194.195.252.175:/var/www/dashboard.tuner.games/
cd -

ssh root@194.195.252.175 'rm /var/www/store.tuner.games/*'
cd saleor-storefront
yarn clean
yarn build
scp -r ./dist/*    root@194.195.252.175:/var/www/store.tuner.games/
cd -

# on remote
# mkdir /var/www/dashboard.tuner.games
# mkdir /var/www/store.tuner.games
# ls /var/www/dashboard.tuner.games
# ls /var/www/store.tuner.games

sudo ln -s /etc/nginx/sites-available/dashboard  /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/store      /etc/nginx/sites-enabled/

nginx -t

systemctl restart nginx



