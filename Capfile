require 'dotenv'
Dotenv.load('.env.local', '.env')
require_relative 'lib/capistrano/droplets'
Droplets.all
# Load DSL and set up stages
require 'capistrano/setup'
# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/yarn'
require 'capistrano/scm/git'
require 'pry'
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/bundler' # Rails needs Bundler, right?
require 'capistrano/rails/assets'
require 'capistrano/env_config'
require 'capistrano/rails/migrations'
install_plugin Capistrano::Puma, load_hooks: false

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
