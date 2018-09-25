class AddVersionToStops < ActiveRecord::Migration[5.2]
  def change
    add_column :stops, :version_id, :integer
    add_index :stops, :version_id
  end
end
