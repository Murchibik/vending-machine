# syntax=docker/dockerfile:1
FROM ruby:2.7.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs postgresql-client yarn

EXPOSE 80

RUN mkdir /app
WORKDIR /app
COPY . /app/

RUN yarn install
RUN bundle install

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]