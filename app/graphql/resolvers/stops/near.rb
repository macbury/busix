module Resolvers
  module Stops
    class Near < BaseCollection
      type [Types::StopType], null: false

      argument :distance, Integer, required: false, description: 'Distance in meters to stop', default_value: 500, prepare: -> (limit, ctx) { [limit, 2_000].min }
      argument :lat, Float, required: true, description: 'Latitude of location'
      argument :lon, Float, required: true, description: 'Longitude of location'

      def resolve(lat:, lon:, distance:, limit:, offset:)
        Version.current.stops.nearby(lat, lon, distance).limit(limit).offset(offset)
      end
    end
  end
end
