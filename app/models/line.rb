class Line < ApplicationRecord
  enum kind: %i(tram bus)
  belongs_to :version
  has_many :directions, dependent: :destroy
  has_many :line_stops, through: :directions
  has_many :stops, -> { distinct('lines.id') }, through: :line_stops

  scope :for_version, -> (version) { where(version_id: version.id) }
  scope :for_kind, -> (kind) { send(kind) }
  scope :by_name, -> (name) { where(name: name) }
  scope :for_ids, -> (ids) { where('lines.id = ANY(ARRAY[?]::int[])', ids) }

  scope :for_departure_ids, -> (line_ids) { 
    joins(line_stops: :departures)
      .where('departures.id = ANY(ARRAY[?]::int[])', line_ids)
      .select('lines.*, departures.id as departure_id')
  }
end
