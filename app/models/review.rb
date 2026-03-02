class Review < ApplicationRecord
  belongs_to :tour, optional: true

  validates :author_name, :body, :rating, presence: true
  validates :rating, inclusion: { in: 1..5 }

  scope :approved, -> { where(approved: true).order(created_at: :desc) }
  scope :featured, -> { approved.limit(6) }
end
