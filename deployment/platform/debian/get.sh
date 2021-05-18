#!/bin/sh

gcl https://github.com/mirumee/saleor

cd saleor

git checkout 2.10
# Branch '2.10' set up to track remote branch '2.10' from 'origin'.
# Switched to a new branch '2.10'

git log

docker-compose pull

> debug redis error when docker-compose not detached
docker exec -it redis:5.0-alpine ash

docker exec -it ecfee8897901 ash

> migrate to resolve log error

docker-compose run --rm api python3 manage.py migrate

docker-compose run --rm api python3 manage.py populatedb --createsuperuser

> view

http://194.195.252.175:8000/graphql/
