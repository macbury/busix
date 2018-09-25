class RenameArrivalsToDepartures < ActiveRecord::Migration[5.2]
  def change
    rename_table :arrivals, :departures
  end
end
