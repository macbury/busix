class CreateArrivals < ActiveRecord::Migration[5.2]
  def change
    create_table :arrivals do |t|
      t.integer :time
      t.integer :day, default: 0
      t.references :line_stop, foreign_key: true

      t.timestamps
    end
  end
end
