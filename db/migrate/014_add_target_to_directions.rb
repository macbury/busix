class AddTargetToDirections < ActiveRecord::Migration[5.2]
  def change
    add_column :directions, :target_id, :integer
    add_index :directions, :target_id
  end
end
