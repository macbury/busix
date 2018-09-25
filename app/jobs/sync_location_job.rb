class SyncLocationJob < ApplicationJob
  def perform(*args)
    Overpass::SyncLocations.call
  end
end
