module Resolvers
  module Directions
    class LineStops < Base
      type Types::LineStopType.connection_type, null: false

      def resolve
        BatchLoader.for(object.id).batch(default_value: []) do |direction_ids, loader|
          LineStop.for_direction_ids(direction_ids).includes(:stop).each do |line_stop| 
            loader.call(line_stop.direction_id) { |memo| memo << line_stop }
          end
        end
      end
    end
  end
end
