source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0.beta4'

# Use the new and improved html sanitizer
gem 'rails-html-sanitizer'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'

# Use bootstrap for a simple design
gem 'bootstrap-sass'
gem 'bootswatch-rails'

# Background jobs
gem 'sidekiq'

# Cron jobs
gem 'whenever', require: false

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Github API for github links
gem 'github_api'

# Tags for bookmarks
gem 'acts-as-taggable-on'

# User registration through social networks
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  # Web console upon error
  gem 'web-console', '~> 2.0.0.beta3'

  # Use Capistrano for deployment
  gem 'capistrano',       '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'

  # Sidekiq management on production
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'

  # Debugging
  gem 'pry-rails'
end

group :development, :test do
  # Use rspec for testing
  gem 'rspec-rails'

  # Mock HTTP responses
  gem 'webmock', require: false
end

group :test do
  # coverage information
  gem 'simplecov', require: false

  # freeze time
  gem 'timecop'
end
