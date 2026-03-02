class Bookings::ToursController < ApplicationController
  def new
    @booking = TourBooking.new
    @booking.tour_id = params[:tour_id] if params[:tour_id]
    @tours = Tour.active
  end

  def create
    @booking = TourBooking.new(booking_params)
    if @booking.save
      redirect_to bookings_confirmation_path(@booking.booking_ref), notice: "Booking confirmed! Reference: #{@booking.booking_ref}"
    else
      @tours = Tour.active
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:tour_booking).permit(:tour_id, :full_name, :email, :phone, :travel_date, :num_passengers, :pickup_point, :special_requests)
  end
end
