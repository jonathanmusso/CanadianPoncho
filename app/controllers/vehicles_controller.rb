class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.approved
    authorize @vehicles
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @primary_image, @images = @vehicle.primary_and_vehicle_images
  end

  def new
    @vehicle = Vehicle.new
    authorize @vehicle
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user = current_user
    authorize @vehicle

    if @vehicle.save
      add_vehicle_images if params[:vehicle][:vehicle_images][:image]
      create_registry_request(@vehicle)

      flash[:notice] = "The Vehicle was added to the Registry."
      redirect_to @vehicle
    else
      flash[:error] = "There was an error saving the Vehicle to the Registry. Please try again."
      render :new
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle
    @primary_image, @images = @vehicle.primary_and_vehicle_images
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle

    if @vehicle.update_attributes(vehicle_params)
      add_vehicle_images if params[:vehicle][:vehicle_images][:image]

      flash[:notice] = "The Vehicle entry was updated."
      redirect_to @vehicle
    else
      flash[:error] = "There was an error updating the Vehicle. Please try again."
      render :edit
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :year, :production_date, :engine, :transmission, :trim, :color, :options, :location, :description, vehicle_images_attributes: [:image])
  end

  def add_vehicle_images
    params[:vehicle][:vehicle_images][:image].each do |i|
        @vehicle.vehicle_images.create!(:image => i)
     end
  end

  def create_registry_request(vehicle)
    RegistryRequest.create(vehicle: vehicle)
  end

end
