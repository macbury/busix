class Stop < ApplicationRecord
  include SimpleNameable

  belongs_to :version
  
  has_many :line_stops, dependent: :destroy
  has_many :directions, through: :line_stops
  has_many :lines, through: :directions

  validates :name, presence: true, uniqueness: { scope: :version_id }

  scope :by_name, ->(name) { where('stops.name ILIKE ?', "#{name.strip}%") }
  scope :for_ids, -> (ids) { where('stops.id = ANY(ARRAY[?]::int[])', ids) }
  scope :nearby, -> (lat, lon, distance_in_meters) do
    where("ST_DWithin(stops.location, ST_GeographyFromText('SRID=4326;POINT(:lon :lat)'), :distance)", lon: lon, lat: lat, distance: distance_in_meters).
    order(Arel.sql("ST_Distance(stops.location, ST_GeographyFromText('SRID=4326;POINT(#{lon.to_f} #{lat.to_f})'))"))
  end

  after_commit :find_geocode, on: :create

  def location?
    location.present?
  end

  private

  def find_geocode
    GeocodeStopJob.perform_async(self.id)
  end
end
