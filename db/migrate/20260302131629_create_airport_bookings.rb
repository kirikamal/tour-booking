class CreateAirportBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :airport_bookings do |t|
      t.string :booking_ref
      t.string :full_name
      t.string :email
      t.string :phone
      t.integer :trip_type
      t.string :airport
      t.string :flight_number
      t.datetime :flight_datetime
      t.integer :num_passengers
      t.text :address
      t.string :vehicle_type
      t.text :notes
      t.integer :status

      t.timestamps
    end
  end
end
