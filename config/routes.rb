require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq/throttled/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == ENV.fetch('SIDEKIQ_BASIC_AUTH_PASSWORD')
end

Rails.application.routes.draw do
  Sidekiq::Throttled::Web.enhance_queues_tab!
  mount Sidekiq::Web => '/workers'
  post '/api' => 'api/graphql#execute', as: :api
  mount GraphiQL::Rails::Engine, at: "/", graphql_path: "/api"
end
