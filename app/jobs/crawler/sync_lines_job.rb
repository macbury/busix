module Crawler
  class SyncLinesJob < ApplicationJob
    sidekiq_options queue: :lines, dead: false, retry: 20, backtrace: true

    def perform(version_id, url)
      version = Version.find(version_id)
      Crawler::Cracow::SyncLines.call(version: version, url: url)
    end
  end
end
