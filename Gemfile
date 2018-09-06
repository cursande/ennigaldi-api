# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 1.2'
gem 'hanami-model', '~> 1.2'
gem 'rake'

# database
gem 'pg'

# network
gem 'http'
gem 'httplog'

# JSON encoding/parsing
gem 'oj'

# Background jobs
gem 'sidekiq'

# caching/key-value datastore
gem 'redis'
gem 'redis-namespace'

# console
gem 'pry'
gem 'pry-stack_explorer'

# image uploading
gem 'shrine'
gem 'hanami-shrine'

# Storage
gem 'aws-sdk'

group :development do
  gem 'hanami-webconsole'
  gem 'rubocop', require: false
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'webmock'
  gem 'shrine-memory'
end

group :production do
  # gem 'puma'
end
