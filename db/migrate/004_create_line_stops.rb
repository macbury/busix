class CreateLineStops < ActiveRecord::Migration[5.2]
  def change
    create_table :line_stops do |t|
      t.references :stop, foreign_key: true
      t.references :line, foreign_key: true

      t.timestamps
    end
  end
end
