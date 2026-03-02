class ToursController < ApplicationController
  def index
    @tours = Tour.active
  end

  def show
    @tour    = Tour.friendly.find(params[:slug])
    @reviews = @tour.reviews.approved.limit(4)
    @related = Tour.active.where.not(id: @tour.id).limit(3)
  end
end
