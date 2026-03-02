class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.string :author_name
      t.integer :rating
      t.text :body
      t.references :tour, null: true, foreign_key: true
      t.boolean :approved

      t.timestamps
    end
  end
end
