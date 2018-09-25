class GeocodeStopJob < ApplicationJob
  sidekiq_options queue: :geocode, dead: false, retry: 20, backtrace: true

  def perform(stop_id)
    stop = Stop.find(stop_id)
    GeocodeStop.call(stop)
  end
end
