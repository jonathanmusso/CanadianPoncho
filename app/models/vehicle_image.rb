class VehicleImage < ActiveRecord::Base
  belongs_to :vehicle
  mount_uploader :image, ImageUploader
end
