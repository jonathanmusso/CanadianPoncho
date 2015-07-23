class AddPrimaryToVehicleImage < ActiveRecord::Migration
  def change
    add_column :vehicle_images, :primary, :boolean, default: false
  end
end
