class AddAncestryToLineStops < ActiveRecord::Migration[5.2]
  def change
    add_column :line_stops, :ancestry, :string
    add_index :line_stops, :ancestry
  end
end
