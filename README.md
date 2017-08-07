# docker php

PHP development environment for Docker.

* PHP 7.0
* Nginx
* php-fpm
* MySql
* Composer
* WP CLI

## Install

* Clone this repo in your project: `git clone https://github.com/constlab/docker.git .docker` or add as submodule `git submodule add https://github.com/constlab/docker.git .docker`
* Copy cmd file in current folder: `cp .docker/docker .`
* In project folder must be env file with params: APP_NAME, DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PREFIX
* If env file does not exists, copy it: `cp .docker/env.example .env`
* Let's start. Run `./docker`. Start params can see in `./docker` file
* Open browser with address: `http://localhost:8080`

## Commands

* `./docker` – start containers
* `./docker stop`
* `./docker restart` – stop and start containers
* `./docker exec` – run command in php container. Example: `./docker exec composer update`
* `./docker bash` – get a shell docker container
* `./docker build`
* `./docker rebuild`
* `./docker wp` – get wp cli
