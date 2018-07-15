source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

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

group :development do
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
  gem 'rubocop', require: false
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'webmock'
  gem 'database_cleaner'
end

group :production do
  # gem 'puma'
end
