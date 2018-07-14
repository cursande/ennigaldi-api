source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

# database
gem 'pg'

# web requests
gem 'http'
gem 'httplog'

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
end

group :production do
  # gem 'puma'
end
