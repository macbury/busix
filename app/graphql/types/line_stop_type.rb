module Types
  class LineStopType < BaseType
    graphql_name 'Stop'
    description 'Place where line stops'

    field :name, String, null: false, description: 'Name of stop'
    field :location, LocationType, null: true, description: 'Latitude and longitude position of this stop'
    field :departures, resolver: Resolvers::Departures::Embedded, null: false, description: 'Departure of line from this stop', complexity: 50

    def name
      object.stop.name
    end

    def location
      object.stop.location
    end
  end
end
