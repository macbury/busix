module Resolvers
  module Departures
    class Timetable < BaseCollection
      type Types::DepartureType.connection_type, null: false

      argument :from, String, required: true, description: 'Name of stop from which you want start'
      argument :to, String, required: true, description: 'Name of final stop of direction'
      argument :at, Arguments::Time, required: true, description: 'Time of departure'
      argument :day, Enums::DepartureKind, required: false, description: 'For what day, ignored if at is added'
      argument :line, String, required: true, description: 'Name of line you want timetable'

      def resolve(from:, to:, day: nil, line:)
        at ||= Time.zone.now
        version = Version.for_date(at).first
        context[:at] = at
        day ||= Departure.day_for_time(at)
        
        target_stop = version.stops.by_name(to).first
        target_line = version.lines.by_name(line).first

        query = Departure
          .joins(:stop)
          .for_version(version)
          .for_stop_name(from)
          .for_direction_target(target_stop)
          .for_line(target_line)
          .by_day(day)
          .order('departures.time ASC')
      end
    end
  end
end
