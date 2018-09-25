class AddIndexToDepartures < ActiveRecord::Migration[5.2]
  def change
    add_index :departures, [:day, :line_stop_id]
  end
end
