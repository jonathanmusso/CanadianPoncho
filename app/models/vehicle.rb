class Vehicle < ActiveRecord::Base
  belongs_to :user

  has_many :vehicle_images
  has_many :registry_requests
  
  #accepts_nested_attributes_for :vehicle_images

  default_scope { order('created_at DESC') }
  scope :approved, -> { joins(:registry_requests).where("registry_requests.approved_at IS NOT NULL") }

  def primary_and_vehicle_images
    primary = primary_image
    rest = vehicle_images.where(primary: false)
    [primary, rest]
  end

  def primary_image
    vehicle_images.where(primary: true).take
  end

end
