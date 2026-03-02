class Vehicle < ApplicationRecord
  has_many :vehicle_bookings, dependent: :destroy
  has_one_attached :photo

  TYPES = %w[Sedan SUV Van Minibus Bus].freeze

  validates :name, presence: true
  validates :vehicle_type, inclusion: { in: TYPES }
  validates :capacity, numericality: { greater_than: 0 }, allow_nil: true

  scope :available, -> { where(available: true).order(:position, :name) }
end
