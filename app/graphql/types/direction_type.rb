module Types
  class DirectionType < BaseType
    description 'Direction in which lines goes'

    field :name, String, null: false
    field :stops, resolver: Resolvers::Directions::LineStops, description: 'All stops for this direction'
    field :line, LineType, null: false, description: 'Line that follows this direction', resolve: -> (direction, args, ctx) do
      BatchLoader.for(direction.line_id).batch do |line_ids, loader|
        Line.for_ids(line_ids).each do |line| 
          loader.call(line.id, line)
        end
      end
    end
    
    field :target, StopType, null: false, description: 'Final stop for this direction', resolve: -> (direction, args, ctx) do
      BatchLoader.for(direction.target_id).batch do |target_ids, loader|
        Stop.for_ids(target_ids).each do |stop| 
          loader.call(stop.id, stop)
        end
      end
    end
  end
end
