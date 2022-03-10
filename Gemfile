source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 1.3.3', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.6.2'

# New rails assets pipeline
gem 'propshaft'

# CSS and JS bundling
gem 'jsbundling-rails'
gem 'cssbundling-rails'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.6'
gem "hiredis"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Background Processing
gem "sidekiq"

group :development, :test do
  # Use environment vairables to set global configs
  gem "dotenv-rails"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.2.0'
  gem 'listen', '>= 3.7', '< 4'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'
  # Use Capistrano for deployment
  gem 'capistrano-rails'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.36'
  gem 'cuprite'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
