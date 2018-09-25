class Direction < ApplicationRecord
  belongs_to :line
  belongs_to :target, class_name: 'Stop', required: false
  has_many :line_stops, dependent: :destroy
  has_many :stops, through: :line_stops

  validates :name, presence: true, uniqueness: { scope: :line_id }

  scope :for_line_ids, -> (line_ids) { where('line_id = ANY(ARRAY[?]::int[])', line_ids) }
  scope :for_departure_ids, -> (departure_ids) { 
    joins(line_stops: :departures)
      .where('departures.id = ANY(ARRAY[?]::int[])', departure_ids)
      .select('directions.*, departures.id as departure_id')
  }
end
