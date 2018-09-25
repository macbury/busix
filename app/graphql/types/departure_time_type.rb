module Types
  class DepartureTimeType < BaseType
    include ActionView::Helpers::DateHelper
    description 'Time of departure'

    field :formatted, String, null: false, description: 'Formatted duration as %H:%M'
    field :duration, Integer, null: false, description: 'Departure as duration from beginning of day in seconds'
    field :date, String, null: false, description: 'Full ISO8601 time of departure'
    field :distance, String, null: false, description: 'Departure time as distance of time in words'
    
    def formatted
      Time.at(object).utc.strftime('%H:%M')
    end

    def duration
      object
    end

    def date
      datetime.to_formatted_s(:iso8601)
    end

    def distance
      distance_of_time_in_words(datetime, Time.zone.now, include_seconds: true) + stuffix
    end

    private

    def at
      context[:at] || Time.zone.now
    end

    def datetime
      (at.at_beginning_of_day + object.seconds)
    end

    def stuffix
      datetime.past? ? ' ago' : ' from now'
    end
  end
end
