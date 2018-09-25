class LineStop < ApplicationRecord
  has_many :departures, dependent: :destroy

  belongs_to :stop
  belongs_to :direction
  has_one :line, through: :direction

  scope :for_direction_ids, -> (direction_ids) { where('direction_id = ANY(ARRAY[?]::int[])', direction_ids) }
end
