# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
ruby '3.2.0'
gem 'rails', '~> 7.0.4'

# data
gem 'bcrypt', '~> 3.1.7'
gem 'email_validator'
gem 'pg', '~> 1.1'
gem 'ranked-model'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# api
gem 'grape'
gem 'grape-entity'
gem 'jbuilder'
gem 'jwt'
gem 'pundit'
gem 'rack-cors'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'grape-swagger'
  gem 'grape-swagger-entity', '~> 0.3'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rswag-ui'

  # performance  tools
  gem 'bullet'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'memory_profiler'
  gem 'rack-mini-profiler', require: false
  gem 'stackprof'

  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers', '~> 5.0'

  gem 'coveralls_reborn', '~> 0.26.0', require: false
  gem 'simplecov-lcov', '~> 0.8.0', require: false
end
