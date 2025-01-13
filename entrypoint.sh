#!/bin/bash
set -e

# Wait for the database to be available
until bundle exec rake db:version; do
  echo "Waiting for database..."
  sleep 2
done

bundle exec rake db:create

# Run database migrations
echo "Running database migrations..."
bundle exec rake db:migrate

# Precompile assets for production
echo "Precompiling assets..."
bundle exec rake assets:precompile

# Start the Rails server
rm -f tmp/pids/server.pid
echo "Starting Rails server..."
rails server -b 0.0.0.0
