module Types
  class DirectionType < BaseType
    description 'Direction in which lines goes'

    field :name, String, null: false
    field :stops, resolver: Resolvers::Directions::LineStops, description: 'All stops for this direction'
    field :line, SimpleLineType, null: false, description: 'Line that follows this direction', resolve: -> (direction, args, ctx) do
      BatchLoader.for(direction.line_id).batch do |line_ids, loader|
        Line.for_ids(line_ids).each do |line| 
          loader.call(line.id, line)
        end
      end
    end

    field :start, StopType, null: false, description: 'First stop for this direction', resolve: -> (direction, args, ctx) do
      DirectionType.resolve_stop(direction, :start_id)
    end
    
    field :target, StopType, null: false, description: 'Final stop for this direction', resolve: -> (direction, args, ctx) do
      DirectionType.resolve_stop(direction, :target_id)
    end

    private

    def self.resolve_stop(direction, association_name_id)
      BatchLoader.for(direction.send(association_name_id)).batch do |stop_ids, loader|
        Stop.for_ids(stop_ids).each do |stop| 
          loader.call(stop.id, stop)
        end
      end
    end
  end
end
