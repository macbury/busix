module Crawler
  module Cracow
    class SyncVersions < BaseTransaction
      tee :drop_old_versions
      step :load_page, with: 'crawler.load_page'
      step :get_current_date, with: 'crawler.extract.current_date'
      step :create_versions

      private

      attr_reader :version

      def drop_old_versions
        Version.where('id < ?', Version.current&.id).each(&:destroy)
        Success(true)
      end

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
