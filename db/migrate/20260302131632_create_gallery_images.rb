class CreateGalleryImages < ActiveRecord::Migration[8.1]
  def change
    create_table :gallery_images do |t|
      t.string :caption
      t.string :category
      t.integer :position

      t.timestamps
    end
  end
end
