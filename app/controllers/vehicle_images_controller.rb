class VehicleImagesController < ApplicationController
    before_action :authenticate_user!

    def update
        @image = VehicleImage.find(params[:id])
        authorize @image
        @image.set_to_primary_and_save
        redirect_to request.referer
    end

    def destroy
        @vehicle_image = VehicleImage.find(params[:id])
        authorize @vehicle_image
        @vehicle = @vehicle_image.vehicle
        @vehicle_image.delete
        redirect_to request.referer
    end
end
