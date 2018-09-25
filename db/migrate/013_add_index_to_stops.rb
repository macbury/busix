class AddIndexToStops < ActiveRecord::Migration[5.2]
  def change
    add_index :stops, :name
    add_index :directions, :name
  end
end
