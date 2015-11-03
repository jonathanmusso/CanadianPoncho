class VehicleImage < ActiveRecord::Base
  belongs_to :vehicle
  mount_uploader :image, ImageUploader

  def set_to_primary_and_save
    VehicleImage.where(vehicle: vehicle).update_all(primary: false)
    self.primary = true
    save
  end

end
