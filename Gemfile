source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
ruby '3.1.2'
gem 'rails', '~> 7.0.4'

# data
gem 'bcrypt', '~> 3.1.7'
gem 'email_validator'
gem 'pg', '~> 1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'ranked-model'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# api
gem 'jwt'
gem 'rack-cors'
gem 'pundit'
gem 'jbuilder'

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
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop-rails', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'faker'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'factory_bot_rails'
end
