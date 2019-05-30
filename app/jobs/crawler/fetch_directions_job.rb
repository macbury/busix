module Crawler
  class FetchDirectionsJob < ApplicationJob
    sidekiq_options queue: :directions, dead: false, retry: 20, backtrace: true

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
