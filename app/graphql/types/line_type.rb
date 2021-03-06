module Types
  class LineType < SimpleLineType
    field :directions, [DirectionType], null: true, complexity: 20, description: 'Directions for lines', resolve: -> (line, args, ctx) do
      BatchLoader.for(line.id).batch(default_value: []) do |line_ids, loader|
        Direction.for_line_ids(line_ids).each do |direction| 
          loader.call(direction.line_id) { |memo| memo << direction }
        end
      end
    end 
  end
end
