class StopLocation < ApplicationRecord
  include SimpleNameable
  enum kind: %i(tram bus)

  validates :location, :name, presence: true

  def self.for_stop(stop)
    where('simple_name = :simple_name OR name ILIKE :name', simple_name: stop.simple_name, name: "#{stop.name}%").first
  end
end
