class RegistryRequest < ActiveRecord::Base
  belongs_to :vehicle

  scope :pending, -> { where(denied_at: nil, approved_at: nil) }
  # scope :approved, -> { where.not(approved_at: nil) }
  # scope :denied, -> { where.not(denied_at: nil) }
end
