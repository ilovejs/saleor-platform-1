# api need build contet, it works when build locally

tag after compose build will not work 
	missing pyparsetime - seems it lack of source code ??

gcl saler 

git checkout 2.10

cd ..
docker-compose up -d api

http://194.195.254.71:8000/graphql/

# store front on vercel

have to give up permission
	change public dir to dist/ in settings

vercel

# what about local ?

# domain

https://www.name.com/account/
https://www.name.com/account/domain/details/tuner.games

# self sign (optoinal)

[todo] firewall

[run-through](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04)

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt

sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096

sudo vim /etc/nginx/snippets/self-signed.conf
> edit like below

ssl_certificate 	/etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

sudo vim /etc/nginx/snippets/ssl-params.conf

> ssl-params.conf

```sh
ssl_protocols TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/dhparam.pem;
ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;
ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
ssl_session_timeout  10m;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off; # Requires nginx >= 1.5.9
ssl_stapling on; # Requires nginx >= 1.3.7
ssl_stapling_verify on; # Requires nginx => 1.3.7
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
# Disable strict transport security for now. You can uncomment the following
# line if you understand the implications.
# add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
```

> move previous conf
sudo cp /etc/nginx/sites-available/example.com /etc/nginx/sites-available/example.com.bak

sudo vim /etc/nginx/sites-available/example.com

```json
server {
	listen 443 ssl;
    listen [::]:443 ssl;
    include snippets/self-signed.conf;
    include snippets/ssl-params.conf;

    server_name example.com www.example.com;

    root /var/www/example.com/html;
    index index.html index.htm index.nginx-debian.html;

    . . .
}
server {
    listen 80;
    listen [::]:80;

    server_name example.com www.example.com;
	
	// 302 redirect temporarily, 301 for perminent
    return 302 https://$server_name$request_uri;
}
```

[certBot](https://www.linode.com/docs/guides/how-to-install-certbot-on-ubuntu-18-04/)

Congratulations! You have successfully enabled https://api.tuner.games

`sudo certbot --nginx`

You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=api.tuner.games
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/api.tuner.games/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/api.tuner.games/privkey.pem

   Your cert will expire on 2021-08-15. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, 
   	
	   run "certbot renew"

 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. 
   
   This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   	
	making regular backups of this folder is ideal.

	`scp -r root@194.195.252.175:/etc/letsencrypt ./certs`

## media

<!-- docker-compose run --rm api python3 manage.py collectstatic --noinput -->

python3 manage.py collectstatic --noinput

/root/app/saleor/static 271 unmodified

## list nginx sites

https://stackoverflow.com/questions/32400933/how-can-i-list-all-vhosts-in-nginx

# s3

[user](tuner-dev1)
AKIA6AWICF26L4JPYV54
hyF9hEKSPN7Xe/VuEKC2wTTBeeeypMi1PPqvy37K

https://docs.saleor.io/docs/developer/running-saleor/s3
https://github.com/adamchainz/django-cors-headers
https://stackoverflow.com/questions/35760943/how-can-i-enable-cors-on-django-rest-framework
https://testdriven.io/blog/storing-django-static-and-media-files-on-amazon-s3/

https://github.com/mirumee/saleor/discussions/5715#discussioncomment-50598


https://medium.com/@dtkatz/3-ways-to-fix-the-cors-error-and-how-access-control-allow-origin-works-d97d55946d9

https://stackoverflow.com/questions/43262121/trying-to-use-fetch-and-pass-in-mode-no-cors



