require 'rack/throttle'

class LimitGraphQl < Rack::Throttle::Daily
  def allowed?(request)
    if request.path == '/api'
      super
    else 
      true
    end
  end
end

Rails.application.config.middleware.use LimitGraphQl, max: 5000, 
                                                    cache: Redis.new(url: ENV.fetch('REDIS_URL')),
                                               key_prefix: :throttle
