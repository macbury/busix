require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/workers'
  post '/api' => 'api/graphql#execute', as: :api
  mount GraphiQL::Rails::Engine, at: "/", graphql_path: "/api"
end
