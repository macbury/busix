class AddStartIdToDirections < ActiveRecord::Migration[5.2]
  def change
    add_column :directions, :start_id, :integer
  end
end
