class TourBooking < ApplicationRecord
  belongs_to :tour

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }, default: :pending

  validates :full_name, :email, :phone, :travel_date, :num_passengers, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :num_passengers, numericality: { greater_than: 0 }

  before_create :generate_booking_ref
  after_create  :calculate_total

  scope :recent, -> { order(created_at: :desc) }

  private

  def generate_booking_ref
    self.booking_ref = "TBK-#{Date.today.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"
  end

  def calculate_total
    update_column(:total_amount_cents, tour.price_cents * num_passengers)
  end
end
