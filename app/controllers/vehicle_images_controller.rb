class VehicleImagesController < ApplicationController
  def update
    @image = VehicleImage.find(params[:id])
    @image.set_to_primary_and_save
    redirect_to request.referer
  end

  def destroy
    @vehicle_image = VehicleImage.find(params[:id])
    @vehicle = @vehicle_image.vehicle
    @vehicle_image.delete
    redirect_to request.referer
  end
end
