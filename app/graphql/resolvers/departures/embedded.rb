module Resolvers
  module Departures
    class Embedded < BaseCollection
      type [Types::DepartureType], null: false

      argument :kind, Enums::DepartureKind, default_value: :all, description: 'For what day, ignored if at is added', required: false
      argument :at, Arguments::Time, required: false, description: 'Time of departure'

      def resolve(kind:, at: nil)
        context[:at] = at
        at ? fetch_at(at) : fetch_by_kind(kind)
      end

      private

      def fetch_at(at)
        BatchLoader.for(object.id).batch(default_value: []) do |line_stop_ids, loader|
          Departure.for_line_stop_ids(line_stop_ids)
                   .for_day(at)
                   .for_time(at)
                   .order('time ASC')
                   .each do |departure| 
            loader.call(departure.line_stop_id) { |memo| memo << departure }
          end
        end
      end

      def fetch_by_kind(kind)
        BatchLoader.for(object.id).batch(default_value: []) do |line_stop_ids, loader|
          Departure.for_line_stop_ids(line_stop_ids)
                   .order('time ASC')
                   .send(kind).each do |departure| 
            loader.call(departure.line_stop_id) { |memo| memo << departure }
          end
        end
      end
    end
  end
end
