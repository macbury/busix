module Types
  class DepartureType < BaseType
    description 'Departure'
    field :time, DepartureTimeType, null: false
    field :day, String, null: false, description: 'Type of day for departure.'

    field :line, LineType, null: false, complexity: 50, resolve: -> (departure, args, ctx) do
      BatchLoader.for(departure.id).batch do |departure_ids, loader|
        Line.for_departure_ids(departure_ids).each do |line| 
          loader.call(line.departure_id, line)
        end
      end
    end

    field :direction, DirectionType, null: false, complexity: 50, resolve: -> (departure, args, ctx) do
      BatchLoader.for(departure.id).batch do |departure_ids, loader|
        Direction.for_departure_ids(departure_ids).each do |direction| 
          loader.call(direction.departure_id, direction)
        end
      end
    end 
  end
end
