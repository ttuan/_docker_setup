# Docker Setup

This is my Docker setup for personal project.

```
cp .env_example .env
cp docker-compose.development.yml docker-compose.yml
docker-compose up
docker-compose run app ./bin/rails db:migrate
docker-compose run app ./bin/rails db:import_master_data
docker-compose run -e RAILS_ENV=test app ./bin/rails db:migrate
docker-compose restart app
```
