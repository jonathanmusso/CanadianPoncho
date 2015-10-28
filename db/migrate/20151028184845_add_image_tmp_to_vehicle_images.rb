class AddImageTmpToVehicleImages < ActiveRecord::Migration
  def change
    add_column :vehicle_images, :image_tmp, :string
  end
end
