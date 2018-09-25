class CreateDirections < ActiveRecord::Migration[5.2]
  def change
    create_table :directions do |t|
      t.string :name
      t.references :line, foreign_key: true

      t.timestamps
    end

    add_column :line_stops, :direction_id, :integer
    remove_column :line_stops, :line_id
    remove_column :line_stops, :ancestry
  end
end
