class VehicleImage < ActiveRecord::Base
  belongs_to :vehicle
  mount_uploader :image, ImageUploader
  process_in_background :image
  store_in_background :image

  def set_to_primary_and_save
    VehicleImage.where(vehicle: vehicle).update_all(primary: false)
    self.primary = true
    save
  end

end
