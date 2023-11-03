#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# RAILS_ENV=production rails db:create db:migrate
# RAILS_ENV=production rails assets:precompile
# RAILS_ENV=production rails assets:clobber
RAILS_ENV=production rails s


exec "$@"