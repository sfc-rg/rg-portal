FROM ruby:2.3.0

RUN set -ex

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash \
 && apt-get install -y nodejs default-jre \
 && npm install --global bower

ENV APP_ROOT /usr/src/app
ENV RAILS_ENV development

WORKDIR $APP_ROOT
# VOLUME vendor/bundle

COPY Gemfile* $APP_ROOT/
COPY Rakefile $APP_ROOT/
COPY . $APP_ROOT

RUN bundle install --path=vendor/bundle \
 && rake emoji \
 && rake bower:install \
 && bundle exec rake db:migrate RAILS_ENV=development \
 && rake sunspot:solr:start

EXPOSE 3000

ENTRYPOINT ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
