Rollbar.configure do |config|
  config.enabled = ENV.key?('ROLLBAR_TOKEN')
  config.access_token = ENV.fetch('ROLLBAR_TOKEN') if config.enabled
end