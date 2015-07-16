class VehicleImagesController < ApplicationController
  def destroy
    @vehicle_image = VehicleImage.find(params[:id])
    @vehicle = @vehicle_image.vehicle
    @vehicle_image.delete
    redirect_to request.referer
  end
end
