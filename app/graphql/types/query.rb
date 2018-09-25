module Types
  class Query < GraphQL::Schema::Object
    description 'The query root of bus/tram timetable'

    field :line, resolver: Resolvers::Lines::Get, null: true, description: 'One specific line'
    field :lines, resolver: Resolvers::Lines::All, null: false, description: 'List all lines'
    field :near_stops, resolver: Resolvers::Stops::Near, null: true, description: 'Find all stops near location'
    field :stops, resolver: Resolvers::Stops::All, null: false, description: 'Find stop by name'
    field :departures, resolver: Resolvers::Departures::All, null: true, description: 'List departures for stop'
    field :nearDepartures, resolver: Resolvers::Departures::Near, null: true, description: 'List departures near location'
  end
end
