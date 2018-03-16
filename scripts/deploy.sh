#!/bin/bash

git pull origin master
docker-compose build app
docker-compose up -d
