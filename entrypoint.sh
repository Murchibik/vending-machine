#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

RAILS_ENV=$RAILS_ENV rails assets:clobber
RAILS_ENV=$RAILS_ENV rails assets:precompile

RAILS_ENV=$RAILS_ENV rails db:prepare

bundle exec rails s -b 0.0.0.0 -p 80

exec "$@"