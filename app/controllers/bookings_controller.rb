class BookingsController < ApplicationController
  def confirmation
    ref = params[:ref]
    @booking = TourBooking.find_by(booking_ref: ref) ||
               AirportBooking.find_by(booking_ref: ref) ||
               VehicleBooking.find_by(booking_ref: ref)

    unless @booking
      redirect_to root_path, alert: "Booking reference not found."
    end
  end
end
