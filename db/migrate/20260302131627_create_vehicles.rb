class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :vehicle_type
      t.integer :capacity
      t.text :description
      t.string :image
      t.boolean :available
      t.integer :position

      t.timestamps
    end
  end
end
