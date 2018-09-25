module Crawler
  class SyncLinesJob < ApplicationJob
    include Sidekiq::Throttled::Worker
    sidekiq_options queue: :lines, dead: false, retry: 20, backtrace: true
    sidekiq_throttle concurrency: { limit: 1 }

    def perform(version_id, url)
      version = Version.find(version_id)
      Crawler::Cracow::SyncLines.call(version: version, url: url)
    end
  end
end
