FROM ruby:2.5.0-slim-stretch
MAINTAINER tuant <tran.van.tuan@framgia.com>

ENV LANG C.UTF-8

ENV APP_DIR /app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

RUN apt-get update --fix-missing
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
build-essential curl git libmariadbclient-dev-compat gnupg imagemagick
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -yq nodejs
RUN apt-get clean

# RUN cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY Gemfile /cache/Gemfile
COPY Gemfile.lock /cache/Gemfile.lock

RUN echo "gem: --no-rdoc --no-ri" > ~/.gemrc
RUN cd /cache && bundle install -j4

COPY . $APP_DIR

RUN chmod +x $APP_DIR/scripts/*
RUN chmod +x $APP_DIR/bin/*

CMD ["scripts/server"]
