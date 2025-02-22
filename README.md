## Release

Use submerge under Linux, 

Add real remote from official, fetch, stage local, pull to local branch

coding...

git push -u origin 2.10

## Version

saleor @ 3b31391    == 2.11.0 official
  milestone-1 released on 4th Nov 2020, not match dashboard version
  
saleor-dashboard @ 8bcb8b7
  [node10] 12 will break it

saleor-storefront @ 3ba4ffa
  [mjs](https://github.com/graphql/graphql-js/issues/1272)
  @saleor/sdk@0.1.5 => require node 12
  >> you should change package.json for storefront !!

## Local deploy API

docker volume ls
docker volume prune
docker system prune -a
docker images

- with ENV in compose
docker-compose up -d api

To rebuild this image `docker-compose build` or `docker-compose up --build`.
* run migration
* visit http://localhost:8000/

http://194.195.254.71:8000/graphql/

```graphql
{
  "data": {
    "shop": {
      "name": "Saleor e-commerce"
    }
  }
}
```

## push docker

**api**

  create public repo on 

    https://hub.docker.com/repository/docker/ilovejs/api

  dk tag saleor-platform_api:latest ilovejs/api:latest

  dk push ilovejs/api:latest

**push Local storefront**

dk push ilovejs/storefront -a

docker pull ilovejs/storefront:2.10

docker run -p 3000:80 ilovejs/storefront:2.10

**deploy & test Remote storefront**

docker-compose up -d storefront
docker-compose stop storefront

http://194.195.254.71:3000/

- view
docker ps -al

- api runs gunicorn
  view http://194.195.254.71:8000/graphql/

**dashboard**

dk build -t dashboard:2.10 .
dk images

dk tag dashboard:2.10 ilovejs/dashboard:2.10

dk push ilovejs/dashboard -a

docker run -p 9000:80 ilovejs/dashboard:2.10

> create user to login

docker-compose run --rm api python3 manage.py populatedb --createsuperuser

> login http://localhost:9000/

admin@example / admin

> run local

docker-compose up -d dashboard
docker-compose stop dashboard

## remote deploy by docker

https://cloud.linode.com/linodes/

ssh root@194.195.254.71

## inside vpc

top
cd app/saleor-platform && docker-compose down

docker system prune -a

> neccessary
docker volume prune

docker pull ilovejs/api

** too much uWsi worker **

vim docker-compose.yml 

docker-compose run -d api

docker images
docker ps

> migration
<!-- docker-compose run --rm api pip3 install pytimeparse -->
docker-compose run --rm api python3 manage.py migrate

http://194.195.254.71:8000/graphql/


#### making sure migration can run
Creating network "saleor-platform_default" with the default driver
Creating network "saleor-platform_saleor-backend-tier" with driver "bridge"
Creating volume "saleor-platform_saleor-db" with local driver
Creating volume "saleor-platform_saleor-redis" with local driver
Creating volume "saleor-platform_saleor-media" with default driver
Creating saleor-platform_redis_1 ... done
Creating saleor-platform_db_1    ... done
Creating saleor-platform_api_1   ... done

### dev run !
docker-compose up -d api

docker build
docker-compose up -d api
docker-compose down

#### when migrate, bash windows should have something !!
docker-compose run --rm api python3 manage.py migrate
docker-compose run --rm api python3 manage.py collectstatic --noinput
docker-compose run --rm api python3 manage.py populatedb --createsuperuser

docker ps -al

- test
view http://194.195.254.71:8000/graphql/
     http://localhost:8000/graphql/


### docker images

saleor-platform_api
saleor-platform_worker
saleor-platform_dashboard
saleor-platform_storefront

mailhog/mailhog
node
redis


# Build amin
  
1. Remove node requirement  
  "engines": {
    "node": ">=12.12.0",
    "npm": ">=6.11.0"
  },

2. Build Admin on powerful computer:

  cd saleor-dashboard/
  API_URI=http://localhost:8000/graphql/ yarn build
  docker build -t saleor-admin .
  docker push 

3. NOT WORKING ?!!

cd .. && rm -rf saleor-dashboard
gcl https://github.com/mirumee/saleor-dashboard

docker build -t saleor-admin .

docker-compose stop dashboard


## issues

* file system watch limit

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# saleor-platform

All Saleor services started from a single repository

*Keep in mind this repository is for local development only and is not meant to be deployed on any production environment! If you're not a developer and just want to try out Saleor you can check our [live demo](https://demo.saleor.io/).*

## Requirements
1. [Docker](https://docs.docker.com/install/)
2. [Docker Compose](https://docs.docker.com/compose/install/)


## How to run it?

1. Clone the repository:

```
$ git clone https://github.com/mirumee/saleor-platform.git --recursive --jobs 3
```

2. We are using shared folders to enable live code reloading. Without this, Docker Compose will not start:
    - Windows/MacOS: Add the cloned `saleor-platform` directory to Docker shared directories (Preferences -> Resources -> File sharing).
    - Windows/MacOS: Make sure that in Docker preferences you have dedicated at least 5 GB of memory (Preferences -> Resources -> Advanced).
    - Linux: No action required, sharing already enabled and memory for Docker engine is not limited.

3. Go to the cloned directory:
```
$ cd saleor-platform
```

4. Build the application:
```
$ docker-compose build
```

5. Apply Django migrations:
```
$ docker-compose run --rm api python3 manage.py migrate
```

6. Collect static files:
```
$ docker-compose run --rm api python3 manage.py collectstatic --noinput
```

7. Populate the database with example data and create the admin user:
```
$ docker-compose run --rm api python3 manage.py populatedb --createsuperuser
```
*Note that `--createsuperuser` argument creates an admin account for `admin@example.com` with the password set to `admin`.*

8. Run the application:
```
$ docker-compose up
```
*Both storefront and dashboard are quite big frontend projects and it might take up to few minutes for them to compile depending on your CPU. If nothing shows up on port 3000 or 9000 wait until `Compiled successfully` shows in the console output.*


## How to update the subprojects to the newest versions?
This repository contains newest stable versions.
When new release appear, pull new version of this repository.
In order to update all of them to their newest versions, run:
```
$ git submodule update --remote
```

You can find the latest version of Saleor, storefront and dashboard in their individual repositories:

- https://github.com/mirumee/saleor
- https://github.com/mirumee/saleor-dashboard
- https://github.com/mirumee/saleor-storefront

## How to solve issues with lack of available space or build errors after update

Most of the time both issues can be solved by cleaning up space taken by old containers. After that, we build again whole platform. 


1. Make sure docker stack is not running
```
$ docker-compose stop
```

2. Remove existing volumes

**Warning!** Proceeding will remove also your database container! If you need existing data, please remove only services which cause problems! https://docs.docker.com/compose/reference/rm/
```
docker-compose rm
```

3. Build fresh containers 
```
docker-compose build
```

4. Now you can run fresh environment using commands from `How to run it?` section. Done!

### Still no available space

If you are getting issues with lack of available space, consider prunning your docker cache:

**Warning!** This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all dangling images
  - all dangling build cache 
  
  More info: https://docs.docker.com/engine/reference/commandline/system_prune/
  
<details><summary>I've been warned</summary>
<p>

```
$ docker system prune
```

</p>
</details>

## How to run application parts?
  - `docker-compose up api worker` for backend services only
  - `docker-compose up` for backend and frontend services


## Where is the application running?
- Saleor Core (API) - http://localhost:8000
- Saleor Storefront - http://localhost:3000
- Saleor Dashboard - http://localhost:9000
- Jaeger UI (APM) - http://localhost:16686
- Mailhog (Test email interface) - http://localhost:8025 


If you have any questions or feedback, do not hesitate to contact us via Spectrum or Gitter:

- https://spectrum.chat/saleor
- https://gitter.im/mirumee/saleor


## License

Disclaimer: Everything you see here is open and free to use as long as you comply with the [license](https://github.com/mirumee/saleor-platform/blob/master/LICENSE). There are no hidden charges. We promise to do our best to fix bugs and improve the code.

Some situations do call for extra code; we can cover exotic use cases or build you a custom e-commerce appliance.

#### Crafted with ❤️ by [Mirumee Software](http://mirumee.com)

hello@mirumee.com

## Git Submodule

https://stackoverflow.com/questions/20929336/git-submodule-add-a-git-directory-is-found-locally-issue

rm -rf .git/modules/saleor

git rm --cached -r saleor-storefront

git submodule add -b milestone-1 https://github.com/ilovejs/saleor

git submodule add -b 2.11.0.fix1 https://github.com/ilovejs/saleor-storefront


