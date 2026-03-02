class HomeController < ApplicationController
  def index
    @tours   = Tour.active.limit(6)
    @reviews = Review.featured
  end
end
