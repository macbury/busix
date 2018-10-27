module Crawler
  module Cracow
    class SyncDirections < BaseTransaction
      step :prepare_load
      step :load_page, with: 'crawler.load_page'
      step :fetch_next_direction, with: 'crawler.extract.directions'
      step :enqueue_directions
      step :fetch_kind, with: 'crawler.extract.kind'
      step :set_kind_for_line
      step :extract_stops, with: 'crawler.extract.stops'
      step :create_stops
      step :create_direction
      step :create_line_stops

      def prepare_load(url:, line:, load_next_direction:)
        @line = line
        @load_next_direction = load_next_direction
        Success(url)
      end

      def fetch_next_direction(page)
        @page = page
        load_next_direction ? super(page) : Success([])
      end

      def enqueue_directions(directions)
        rest_directions = directions[1..-1] || []
        rest_directions.each do |direction|
          Crawler::FetchDirectionsJob.perform_async(line.id, direction[:url], false)
        end
        Success(page)
      end

      def set_kind_for_line(kind:)
        line.update_attributes(kind: kind)

        Success(page)
      end

      def create_stops(stops)
        version = line.version
        ActiveRecord::Base.transaction do
          stops.each do |data|
            data[:stop] = version.stops.find_or_create_by!(name: data[:name])
          end
        end
        Success(stops)
      end

      def create_direction(stops)
        direction_name = [stops.first[:name], stops.last[:name]].join(' - ')
        direction = line.directions.find_or_create_by(name: direction_name)
        Success(stops: stops, direction: direction)
      end

      def create_line_stops(stops:, direction:)
        ActiveRecord::Base.transaction do
          direction.line_stops.destroy_all
          stops.map { |data| data[:line_stop] = direction.line_stops.find_or_create_by!(stop: data[:stop]) }
          direction.start  = stops.first[:line_stop].stop
          direction.target = stops.last[:line_stop].stop

          throw "start for direction #{direction.id} is null" unless direction.start
          throw "target for direction #{direction.id} is null" unless direction.target

          direction.save
        end
        
        stops.each do |data| 
          url = data[:url]
          FetchLineStopJob.perform_async(data[:line_stop].id, url) if url
        end

        Success(stops.map { |s| s[:line_stop] })
      end

      private

      attr_reader :line, :load_next_direction, :page
    end
  end
end
