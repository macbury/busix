module Crawler
  class FetchLineStopJob < ApplicationJob
    sidekiq_options queue: :stops, dead: false, retry: 20, backtrace: true

    def perform(line_stop_id, url)
      line_stop = LineStop.find_by(id: line_stop_id)
      return unless line_stop
      Crawler::Cracow::SyncLineStop.call(
        line_stop: line_stop,
        url: url
      ) do |response|
        response.success { Rails.logger.info "Imported line: #{line.name} for #{stop.name}" }
        response.failure { |error| raise error }
      end
    end
  end
end
