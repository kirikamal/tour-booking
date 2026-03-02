class CreateTours < ActiveRecord::Migration[8.1]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :price_cents
      t.string :duration
      t.string :departure_time
      t.string :pickup_location
      t.integer :max_passengers
      t.string :featured_image
      t.boolean :active
      t.integer :position

      t.timestamps
    end
  end
end
