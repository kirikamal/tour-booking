class AirportBooking < ApplicationRecord
  enum :trip_type, { pickup: 0, dropoff: 1 }, default: :pickup
  enum :status,    { pending: 0, confirmed: 1, cancelled: 2 }, default: :pending

  AIRPORTS    = [ "Sydney (SYD)", "Melbourne (MEL)", "Brisbane (BNE)", "Other" ].freeze
  VEHICLE_TYPES = %w[Sedan SUV Van Minibus].freeze

  validates :full_name, :email, :phone, :airport, :address, :num_passengers, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create :generate_booking_ref

  scope :recent, -> { order(created_at: :desc) }

  private

  def generate_booking_ref
    self.booking_ref = "APT-#{Date.today.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"
  end
end
