require 'sidekiq/throttled'
Sidekiq::Throttled.setup!

REDIS_URL = ENV.fetch('REDIS_URL')
Sidekiq.default_worker_options = { backtrace: true, retry: 25, dead: false }

Sidekiq.configure_server do |config|
  job_count = ENV.fetch('SIDEKIQ_CONCURRENCY', 50).to_i
  config.options[:concurrency] = job_count
  config.redis = ConnectionPool.new(size: job_count + 5, timeout: 5) do 
    Redis.new(url: REDIS_URL)
  end

  config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
  config['pool'] = job_count + 1
  
  ActiveRecord::Base.establish_connection(config)

  schedule_file = Rails.root.join('config/schedule.yml').to_s
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_URL }
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == ENV.fetch['SIDEKIQ_BASIC_AUTH_PASSWORD']
end
