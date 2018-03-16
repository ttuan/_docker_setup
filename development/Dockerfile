FROM ruby:2.4.1
MAINTAINER ttuan <tuantv.nhnd@gmail.com>
ENV RAILS_ROOT=/usr/app/${APP_NAME}
ENV RAILS_ENV=${RAILS_ENV}

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client libproj-dev nodejs less

# Dependencies for rgeo
RUN apt-get --no-install-recommends -y install libgeos-dev libproj-dev
# Add libgeos symlinks for rgeo gem to be able to find it
RUN ln -sf /usr/lib/libgeos-3.4.2.so /usr/lib/libgeos.so && ln -sf /usr/lib/libgeos-3.4.2.so /usr/lib/libgeos.so.1

RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT
ENV BUNDLE_PATH /box
COPY . .
EXPOSE 3000
