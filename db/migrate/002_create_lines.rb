class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines do |t|
      t.integer :kind, default: 0
      t.integer :name
      t.references :version

      t.timestamps
    end
  end
end
