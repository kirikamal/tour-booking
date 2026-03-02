class MakeReviewTourOptional < ActiveRecord::Migration[8.1]
  def change
    change_column_null :reviews, :tour_id, true
  end
end
