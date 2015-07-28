class RemoveApprovedFromVehicles < ActiveRecord::Migration
  def change
    remove_column :vehicles, :approved, :boolean
  end
end
