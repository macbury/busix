source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'

gem 'ancestry', '~> 3.0', '>= 3.0.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
gem 'rgeo-activerecord'
gem 'activerecord-postgis-adapter', '~> 5.2', '>= 5.2.1' 
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '>= 4.0.x'
gem 'mechanize'
gem 'pry-rails'
gem 'geokit'
gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'dotenv-rails'
gem 'pry'
gem 'jbuilder'
gem 'dry-transaction'
gem 'dry-auto_inject'
gem 'dry-validation'
gem 'attr_encrypted'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq-throttled'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise-jwt', '~> 0.5.7'
gem 'listen'
gem 'overpass-api-ruby'
gem 'graphql'
gem 'batch-loader'
gem 'graphiql-rails'
gem 'chronic'
gem 'holidays'
gem 'rollbar'
gem "skylight"
gem 'shortest_path'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'rspec-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :deployment do
  gem 'droplet_kit'
  gem 'capistrano', '~> 3.10'
  gem 'capistrano-bundler', '~> 1.3'
  gem 'capistrano-rails'
  gem 'capistrano-yarn'
  gem 'capistrano3-puma', git: 'https://github.com/seuros/capistrano-puma'
  gem 'capistrano-env_config'
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'rspec-sidekiq'
  gem 'factory_bot', '~> 4.10'
  gem 'shoulda-matchers', require: 'shoulda/matchers'
  gem 'database_cleaner', '~> 1.7'
  gem 'timecop'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
