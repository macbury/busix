class AddIndexToArrivals < ActiveRecord::Migration[5.2]
  def change
    add_index :arrivals, [:line_stop_id, :day, :time]
  end
end
