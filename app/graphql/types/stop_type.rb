module Types
  class StopType < BaseType
    graphql_name 'NearStop'
    description 'Place where line stops'

    field :name, String, null: false, description: 'Name of stop'
    field :location, LocationType, null: true, description: 'Latitude and longitude position of this stop'
    field :directions, DirectionType.connection_type, null: false, description: 'What directions are available on this stop'
  end
end
