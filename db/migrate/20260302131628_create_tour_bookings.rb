class CreateTourBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :tour_bookings do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :booking_ref
      t.string :full_name
      t.string :email
      t.string :phone
      t.date :travel_date
      t.integer :num_passengers
      t.string :pickup_point
      t.text :special_requests
      t.integer :status
      t.integer :total_amount_cents

      t.timestamps
    end
  end
end
