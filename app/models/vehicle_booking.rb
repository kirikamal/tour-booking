class VehicleBooking < ApplicationRecord
  belongs_to :vehicle

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }, default: :pending

  validates :full_name, :email, :phone, :pickup_date, :return_date, :pickup_location, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate  :return_after_pickup

  before_create :generate_booking_ref

  scope :recent, -> { order(created_at: :desc) }

  private

  def generate_booking_ref
    self.booking_ref = "VHR-#{Date.today.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"
  end

  def return_after_pickup
    return unless pickup_date && return_date
    errors.add(:return_date, "must be on or after pickup date") if return_date < pickup_date
  end
end
