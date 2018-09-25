module Crawler
  class SyncVersionsJob < ApplicationJob
    sidekiq_options queue: :versions, dead: false, retry: 20, backtrace: true

    def perform(*args)
      Crawler::Cracow::SyncVersions.call
    end
  end
end
