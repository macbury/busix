class AddSimpleNameToStops < ActiveRecord::Migration[5.2]
  def change
    add_column :stops, :simple_name, :string
    add_index :stops, :simple_name

    Stop.all.each do |stop|
      stop.build_simple_name
      stop.save
    end

    add_column :stop_locations, :simple_name, :string
    add_index :stop_locations, :simple_name

    StopLocation.all.each do |location|
      location.build_simple_name
      location.save
    end
  end
end
