FROM ruby:2.2

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

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b0.0.0.0"]
