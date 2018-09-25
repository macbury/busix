module Crawler
  module Cracow
    class SyncLines < BaseTransaction
      step :prepare
      step :load_page, with: 'crawler.load_page'
      step :fetch_lines, with: 'crawler.extract.lines'
      step :create_lines

      private

      attr_reader :version

      def prepare(version:, url:)
        @version = version
        Success(url)
      end

      def create_lines(lines)
        out = lines.map do |line_no, url|
          line = version.lines.find_or_create_by(name: line_no)
          Crawler::FetchDirectionsJob.perform_async(line.id, url.to_s, true)

          line
        end

        return Success(out)
      end
    end
  end
end
