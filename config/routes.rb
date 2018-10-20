require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq/throttled/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == ENV.fetch('SIDEKIQ_BASIC_AUTH_PASSWORD')
end

Rails.application.routes.draw do
  Sidekiq::Throttled::Web.enhance_queues_tab!
  mount Sidekiq::Web => '/workers'
  
  post '/api' => 'api/graphql#execute'
  mount GraphiQL::Rails::Engine, at: '/api/explorer', graphql_path: '/api'

  get '/about' => redirect('https://github.com/macbury/busix')

  root 'frontend#show'
  match '*path' => 'frontend#show', via: [:get]
end
