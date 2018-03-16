#!/bin/bash

cd ../$APP_NAME
git pull origin master
docker-compose build app
