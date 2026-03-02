class GalleryImage < ApplicationRecord
  has_one_attached :image

  CATEGORIES = %w[tours vehicles events team].freeze

  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true

  scope :ordered,  -> { order(:position, :id) }
  scope :by_category, ->(cat) { where(category: cat) }
end
