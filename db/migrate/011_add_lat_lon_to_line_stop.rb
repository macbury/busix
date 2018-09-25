class AddLatLonToLineStop < ActiveRecord::Migration[5.2]
  def change
    add_column :stops, :location, :st_point, geographic: true
    add_index :stops, :location, using: :gist
  end
end
