class Bookings::VehiclesController < ApplicationController
  def new
    @booking = VehicleBooking.new
    @vehicles = Vehicle.available
  end

  def create
    @booking = VehicleBooking.new(booking_params)
    if @booking.save
      redirect_to bookings_confirmation_path(@booking.booking_ref), notice: "Vehicle hire booked! Reference: #{@booking.booking_ref}"
    else
      @vehicles = Vehicle.available
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:vehicle_booking).permit(:vehicle_id, :full_name, :email, :phone, :pickup_date, :return_date, :pickup_location, :num_passengers, :notes)
  end
end
