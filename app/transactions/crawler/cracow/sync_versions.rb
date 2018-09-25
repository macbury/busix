module Crawler
  module Cracow
    class SyncVersions < BaseTransaction
      step :load_page, with: 'crawler.load_page'
      step :get_current_date, with: 'crawler.extract.current_date'
      step :create_versions

      private

      attr_reader :version

      def create_versions(dates)
        versions = dates.map do |date|
          version = Version.new(date: date[:date])
          Crawler::SyncLinesJob.perform_async(version.id, date[:url]) if version.save
          version
        end

        Success(versions)
      end
    end
  end
end
