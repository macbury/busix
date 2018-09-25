module Types
  class LocationType < BaseType
    description 'Latitude and longitude position'

    field :latitude, String, null: true, resolve: -> (point, args, ctx) do
      point&.latitude
    end 

    field :longitude, String, null: true, resolve: -> (point, args, ctx) do
      point&.longitude
    end 
  end
end
