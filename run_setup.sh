cd ../$APP_NAME
mkdir -p containers/$RAILS_ENV
mkdir -p containers/scripts

# Add necessary files for dockerizing
envsubst < ../_docker_setup/$RAILS_ENV/Dockerfile > containers/$RAILS_ENV/Dockerfile
envsubst < ../_docker_setup/$RAILS_ENV/docker-compose.yml > containers/${RAILS_ENV}/docker-compose.yml
envsubst < ../_docker_setup/$RAILS_ENV/entrypoint > containers/${RAILS_ENV}/entrypoint
cp ../_docker_setup/scripts/wait-for-it.sh containers/scripts/wait-for-it.sh
cp ../_docker_setup/scripts/deploy.sh containers/scripts/deploy.sh
chmod +x containers/${RAILS_ENV}/entrypoint
chmod +x containers/scripts/wait-for-it.sh

envsubst < ../_docker_setup/$RAILS_ENV/.env > containers/${RAILS_ENV}/.env
# envsubst < ../_docker_setup/$RAILS_ENV/database.yml >> config/database.yml

[ -e docker-compose.yml ] && rm docker-compose.yml
ln -s containers/${RAILS_ENV}/docker-compose.yml

if [ "$RAILS_ENV" == "production" ]
then
  envsubst < ../_docker_setup/$RAILS_ENV/nginx.conf > containers/$RAILS_ENV/nginx.conf
  cp ../_docker_setup/$RAILS_ENV/server.csr containers/$RAILS_ENV/server.csr
  cp ../_docker_setup/$RAILS_ENV/server.key containers/$RAILS_ENV/server.key
  # Add nulldb gem to allow creating assets without a db connection
  # read: http://blog.zeit.io/use-a-fake-db-adapter-to-play-nice-with-rails-assets-precompilation/"
  # echo "gem 'activerecord-nulldb-adapter'" >> Gemfile
  docker-compose up -d
else
  echo "development"
  docker-compose build
  docker-compose run app bundle install
  docker-compose up -d
  open http://`docker-machine ip`:3000
fi
