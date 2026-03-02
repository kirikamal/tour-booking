class Bookings::AirportsController < ApplicationController
  def new
    @booking = AirportBooking.new
  end

  def create
    @booking = AirportBooking.new(booking_params)
    if @booking.save
      redirect_to bookings_confirmation_path(@booking.booking_ref), notice: "Airport transfer booked! Reference: #{@booking.booking_ref}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:airport_booking).permit(:full_name, :email, :phone, :trip_type, :airport, :flight_number, :flight_datetime, :num_passengers, :address, :vehicle_type, :notes)
  end
end
