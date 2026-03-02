class ReviewsController < ApplicationController
  def index
    @reviews = Review.approved
    @review  = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: "Thank you! Your review has been submitted and will appear after approval."
    else
      @reviews = Review.approved
      render :index, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:author_name, :rating, :body, :tour_id)
  end
end
