class Vehicle < ActiveRecord::Base
  belongs_to :user

  has_many :vehicle_images
  #accepts_nested_attributes_for :vehicle_images

  default_scope { order('created_at DESC') }

  def primary_and_vehicle_images
    primary = vehicle_images.where(primary: true).take
    rest = vehicle_images.where(primary: false)
    [primary, rest]
  end

end
