#!/bin/sh

# export STOREFRONT_URL=http://194.195.252.175:3000/
# export DASHBOARD_URL=http://194.195.252.175:9000/
# export ALLOWED_HOSTS=localhost,194.195.252.175,tuner.games,www.tuner.games

export STOREFRONT_URL=https://store.tuner.games/

export DASHBOARD_URL=https://dashboard.tuner.games/

export ALLOWED_HOSTS="*"

## db is internal name !!
# export DATABASE_URL=postgres://saleor:saleor@db/saleor
export DATABASE_URL=postgres://saleor:saleor@localhost/saleor

export CELERY_BROKER_URL=redis://redis:6379/1

export SECRET_KEY=MjM0c2FkZmFzZGZERkdERkcK

export EMAIL_URL=smtp://mailhog:1025
export DEFAULT_FROM_EMAIL=noreply@tuner.games

export STATIC_URL=${STATIC_URL:-/static/}
# SECRET_KEY=MjM0c2FkZmFzZGZERkdERkcK STATIC_URL=${STATIC_URL} python3 manage.py collectstatic --no-input

# http://tuner.games:3000/
# python3 manage.py runserver 0.0.0.0:3000

cd saleor
# no 80, no test
python3 manage.py runserver 0.0.0.0:3000

# http://194.195.252.175:3000/graphql/
# https://www.linode.com/docs/guides/obtain-a-commercially-signed-tls-certificate/#create-a-certificate-signing-request-csr

# run in bg, recall with fg
# nohup ./api.sh&
