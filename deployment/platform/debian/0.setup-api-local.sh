
# gcc
sudo apt install build-essential
# uwsgi
sudo apt install libpython3-all-dev

# pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py

cd saleor
pip3 install -r requirements.txt --user

source prod.env
python3 manage.py runserver

# copied to '/root/app/saleor/static'.
STATIC_URL="/static/"
SECRET_KEY=MTI0MjM0MkRGR0ZEU0ZHCg==  STATIC_URL=${STATIC_URL} python3 manage.py collectstatic --no-input

mkdir -p /app/media /app/static

chown -R saleor:saleor /app/

apt install nginx

# mkdir /etc/nginx/sites-enabled/api
# cat /etc/nginx/sites-enabled/default

vim /etc/nginx/sites-available/api

sudo ln -s /etc/nginx/sites-available/api /etc/nginx/sites-enabled/api

sudo service nginx configtest
sudo service nginx restart

