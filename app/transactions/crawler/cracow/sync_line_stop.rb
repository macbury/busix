module Crawler
  module Cracow
    class SyncLineStop < BaseTransaction
      step :prepare_load
      step :load_page, with: 'crawler.load_page'
      step :extract_departures, with: 'crawler.extract.departures'
      step :save
      
      def prepare_load(line_stop:, url:)
        @line_stop = line_stop
        Success(url)
      end

      def save(departures)
        return Failure('Already imported departures') unless line_stop.departures.empty?
        ActiveRecord::Base.transaction do
          line_stop.departures.destroy_all
          departures.map do |departure|
            line_stop.departures.create(departure)
          end
        end
        
        Success(line_stop.departures)
      end

      private

      attr_reader :line_stop
    end
  end
end
