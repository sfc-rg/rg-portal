FROM ruby:2.3.0-alpine

RUN set -ex
RUN apk add --update alpine-sdk linux-headers mariadb-dev sqlite-dev nodejs tzdata
RUN npm install --global bower

WORKDIR /usr/src/app
ADD . /usr/src/app

RUN bundle install --without therubyracer --path=vendor/bundle
RUN rake emoji && \
    rake bower:install['--allow-root']

RUN RAILS_ENV=development bundle exec rake db:migrate

ENTRYPOINT bundle exec rails server -b 0.0.0.0
