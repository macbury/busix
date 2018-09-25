module Resolvers
  module Departures
    class All < BaseCollection
      type [Types::DepartureType], null: false

      argument :from, String, required: true, description: 'Name of stop from which you want start'
      argument :at, Arguments::Time, required: true, description: 'Time of departure'
      argument :to, String, required: false, description: 'Name of final stop of direction'

      def resolve(limit:, offset:, from:, to: nil, at:)
        at ||= Time.zone.now
        version = Version.for_date(at).first
        context[:at] = at
        
        target_stop = to ? version.stops.by_name(to).first : nil
        Departure
          .joins(:stop)
          .for_version(version)
          .for_stop_name(from)
          .for_direction_target(target_stop)
          .for_day(at)
          .for_time(at)
          .limit(limit)
          .offset(offset)
          .order('departures.time ASC')
      end
    end
  end
end
