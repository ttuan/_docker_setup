#!/bin/bash

cd ../$APP_NAME
git clone $REPO_URL
docker-compose build app
