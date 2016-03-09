FROM ruby:2.3.0

MAINTAINER luka.dornhecker@gmail.com

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

RUN mkdir -p /imgupl
WORKDIR /imgupl

COPY Gemfile Gemfile.lock /imgupl/
RUN gem install bundler && bundle install --jobs 20 --retry 5

ADD . /imgupl

ENV PORT 3000

EXPOSE $PORT

CMD bundle exec puma -C config/puma.rb
