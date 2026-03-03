class AddFeaturedImageUrlToTours < ActiveRecord::Migration[8.1]
  def change
    add_column :tours, :featured_image_url, :string
  end
end
