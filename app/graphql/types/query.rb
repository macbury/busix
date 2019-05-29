module Types
  class Query < GraphQL::Schema::Object
    description 'The query root of bus/tram timetable'

    field :line, resolver: Resolvers::Lines::Get, null: true, description: 'One specific line'
    field :lines, resolver: Resolvers::Lines::All, null: false, description: 'List all lines'
    field :stops, resolver: Resolvers::Stops::All, null: false, description: 'Find stop by name'

    field :timetable, resolver: Resolvers::Departures::Timetable, null: true, description: 'List all departures for given stop and line'
    field :departures, resolver: Resolvers::Departures::All, null: true, description: 'List departures for stop'
  end
end
