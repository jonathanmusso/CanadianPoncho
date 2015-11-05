class VehicleImage < ActiveRecord::Base
  belongs_to :vehicle
  mount_uploader :image, ImageUploader

  validates :image, file_size: { less_than: 500.kilobytes }

  def set_to_primary_and_save
    VehicleImage.where(vehicle: vehicle).update_all(primary: false)
    self.primary = true
    save
  end

end
