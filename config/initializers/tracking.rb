Rails.application.config.middleware.use(Rack::Tracker) do
  handler :google_analytics, { 
    tracker: ENV.fetch('GOOGLE_ANALYTICS_TRACKING_CODE'),
    anonymize_ip: true
  }
end
