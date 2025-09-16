#!/bin/bash

set -e

# Wait for the database to be ready
until pg_isready -h db -p 5432; do
  echo "Waiting for the database to be ready..."
  sleep 2
done

# Remove pre-existing server.pid if it exists
rm -f /app/tmp/pids/server.pid

# create and migrate
bundle exec rails db:create db:migrate

# Compile assets
bundle exec rails assets:precompile

exec "$@"