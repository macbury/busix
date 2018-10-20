module Resolvers
  module Departures
    class Near < BaseCollection
      type Types::DepartureType.connection_type, null: false

      argument :distance, Integer, required: false, description: 'Distance in meters to stop', default_value: 500, prepare: -> (limit, ctx) { [limit, 2_000].min }
      argument :lat, Float, required: true, description: 'Latitude of location'
      argument :lon, Float, required: true, description: 'Longitude of location'

      argument :at, Arguments::Time, required: true, description: 'Time of departure'
      argument :to, String, required: false, description: 'Name of final stop'

      def resolve(stop: nil, to: nil, at:, lat:, lon:, distance:)
        at ||= Time.zone.now
        context[:at] = at
        version = Version.for_date(at).first
        
        target_stop = to ? version.stops.by_name(to).first : nil
        Departure
          .joins(:stop)
          .for_version(version)
          .for_stop_name(stop)
          .for_direction_target(target_stop)
          .for_day(at)
          .for_time(at)
          .nearby(lat, lon, distance)
          .order('departures.time ASC')
      end
    end
  end
end
