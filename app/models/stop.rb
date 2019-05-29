class Stop < ApplicationRecord
  include SimpleNameable

  belongs_to :version
  
  has_many :line_stops, dependent: :destroy
  has_many :directions, through: :line_stops
  has_many :lines, through: :directions

  validates :name, presence: true, uniqueness: { scope: :version_id }

  scope :by_name, ->(name) { where('stops.name ILIKE ?', "#{name.strip}%") }
  scope :for_ids, -> (ids) { where('stops.id = ANY(ARRAY[?]::int[])', ids) }

  def location?
    location.present?
  end
end
