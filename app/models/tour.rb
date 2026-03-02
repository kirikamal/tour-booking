class Tour < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :tour_bookings, dependent: :destroy
  has_many :reviews, dependent: :nullify
  has_one_attached :hero_image

  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :max_passengers, numericality: { greater_than: 0 }, allow_nil: true

  scope :active,   -> { where(active: true).order(:position, :name) }
  scope :featured, -> { active.limit(6) }

  def price
    price_cents.to_f / 100
  end

  def price_display
    "$#{format('%.0f', price)}"
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
