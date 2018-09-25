module Crawler
  class FetchDirectionsJob < ApplicationJob
    include Sidekiq::Throttled::Worker
    
    sidekiq_options queue: :directions, dead: false, retry: 20, backtrace: true
    sidekiq_throttle concurrency: { limit: 1 }

    def perform(line_id, url, load_next_direction)
      line = Line.find(line_id)

      Crawler::Cracow::SyncDirections.call(
        url: url, 
        line: line, 
        load_next_direction: load_next_direction
      )
    end
  end
end
