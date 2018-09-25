class CreateStopLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :stop_locations do |t|
      t.st_point :location, geographic: true
      t.integer :kind
      t.string :name
      t.bigint :node_id

      t.timestamps
    end
    add_index :stop_locations, :name
    add_index :stop_locations, :node_id
  end
end
