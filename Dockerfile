FROM ruby:3.0-bullseye as base

RUN apt-get update -qq && apt-get install -y curl gnupg gcc g++ make

RUN curl -sL https://deb.nodesource.com/setup_16.x  | bash -

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs yarn apt-utils

WORKDIR /docker/app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

# RUN RAILS_ENV=production bundle exec rails assets:precompile

ADD . /docker/app

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD [ "bundle","exec", "puma", "config.ru"] # CMD ["rails","server"] # you can also write like this.