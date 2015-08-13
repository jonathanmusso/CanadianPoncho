class Vehicle < ActiveRecord::Base
  belongs_to :user

  has_many :vehicle_images
  has_many :registry_requests
  
  #accepts_nested_attributes_for :vehicle_images

  default_scope { order('created_at DESC') }
  scope :approved, -> { joins(:registry_requests).where("registry_requests.approved_at IS NOT NULL") }
  scope :pending, -> { joins(:registry_requests).where("registry_requests.approved_at IS NULL AND registry_requests.denied_at IS NULL") }
  scope :denied, -> { joins(:registry_requests).where("registry_requests.denied_at IS NOT NULL") }
  
  def primary_and_vehicle_images
    primary = primary_image
    rest = vehicle_images.where(primary: false)
    [primary, rest]
  end

  def primary_image
    vehicle_images.where(primary: true).take
  end

  def vehicle_request_notes
    # self.registry_requests.each do |rr|
    #   rr.notes
    # end

    # registry_requests.pluck(:notes)

    registry_requests.pluck(:notes).join(" ")
  end
end
