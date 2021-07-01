#!/bin/bash
sudo service nginx start
cd /app
# RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop
bin/setup
bundle exec pumactl start
