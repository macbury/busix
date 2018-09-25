require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq/throttled/web'

Rails.application.routes.draw do
  Sidekiq::Throttled::Web.enhance_queues_tab!
  mount Sidekiq::Web => '/workers'
  
  post '/api' => 'api/graphql#execute'
  mount GraphiQL::Rails::Engine, at: '/api/explorer', graphql_path: '/api'
end
