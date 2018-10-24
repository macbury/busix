module Resolvers
  module Departures
    class Timetable < BaseCollection
      type Types::DepartureType.connection_type, null: false

      argument :from, String, required: true, description: 'Name of stop from which you want start'
      argument :kind, Enums::DepartureKind, default_value: :all, description: 'For what day, ignored if at is added', required: false
      argument :to, String, required: true, description: 'Name of final stop of direction'
      argument :line, String, required: true, description: 'Name of line you want timetable'

      def resolve(from:, to:, kind:, line:)
        version = Version.latest.first
        
        target_stop = version.stops.by_name(to).first
        target_line = version.lines.by_name(line).first

        Departure
          .joins(:stop)
          .for_version(version)
          .for_stop_name(from)
          .for_direction_target(target_stop)
          .for_line(target_line)
          .order('departures.time ASC')
          .by_kind(kind)
      end
    end
  end
end
