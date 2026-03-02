class CreateVehicleBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicle_bookings do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :booking_ref
      t.string :full_name
      t.string :email
      t.string :phone
      t.date :pickup_date
      t.date :return_date
      t.string :pickup_location
      t.integer :num_passengers
      t.text :notes
      t.integer :status

      t.timestamps
    end
  end
end
