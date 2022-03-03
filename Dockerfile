FROM ruby:3.0.3

ENV NODE_VERSION 16

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt update && apt install --no-install-recommends nodejs
RUN apt update && apt install --no-install-recommends yarn

RUN mkdir app

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /app