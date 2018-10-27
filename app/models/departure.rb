class Departure < ApplicationRecord
  enum day: %i(normal saturday holidays)
  belongs_to :line_stop
  has_one :stop, through: :line_stop
  has_one :direction, through: :line_stop
  has_one :line, through: :direction

  validates :time, presence: true

  scope :for_stop_name, -> (stop) { where('stops.name ILIKE ?', "#{stop}%") }
  scope :for_version, -> (version) { where('stops.version_id = :version_id', version_id: version.id) }

  scope :for_direction_target, -> (target_stop) {
    target_stop ? joins(:direction).where('directions.target_id = ?', target_stop.id) : all
  }

  scope :for_line, -> (line) { line ? joins(:line).where('lines.id = ?', line.id) : all }

  scope :for_time, -> (time) {
    duration = (time - time.at_beginning_of_day).round
    where('departures.time >= :duration', duration: duration)
  }

  scope :by_day, -> (day) { day == :all ? all : where(day: day) }

  scope :for_day, -> (time) { where(day: day_for_time(time)) }

  scope :for_line_stop_ids, -> (line_stop_ids) { where('line_stop_id = ANY(ARRAY[?]::int[])', line_stop_ids) }

  scope :nearby, -> (lat, lon, distance_in_meters) do
    joins(:stop)
      .where("ST_DWithin(stops.location, ST_GeographyFromText('SRID=4326;POINT(:lon :lat)'), :distance)", lon: lon, lat: lat, distance: distance_in_meters)
      .order(Arel.sql("ST_Distance(stops.location, ST_GeographyFromText('SRID=4326;POINT(#{lon.to_f} #{lat.to_f})'))"))
  end

  def self.day_for_time(time)
    if !Holidays.on(time, :pl).empty? || time.sunday?
      :holidays
    elsif time.saturday?
      :saturday
    else
      :normal
    end
  end
end
