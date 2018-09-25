# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'busix'
set :repo_url, 'git@github.com:macbury/busix.git'
set :deploy_to, '/busix'

set :log_level, :info
set :pty, false

set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :keep_releases, 5

set :puma_threads, [0, 20]
set :puma_workers, 2

set :rails_env, fetch(:stage)
set :assets_roles, [:app]
set :migration_role, :app

set :default_env, {
  RAILS_ENV: fetch(:rails_env)
}

set :puma_bind, ['tcp://0.0.0.0:3000', "unix:///#{shared_path}/tmp/sockets/puma.sock"]
set :puma_role, :app

set :sidekiq_role, :app

after 'deploy:starting', 'systemctl:sidekiq:stop'
after 'deploy:published', 'puma:config'
after 'puma:config', 'systemctl:puma:restart'
after 'systemctl:puma:restart', 'systemctl:sidekiq:restart'
