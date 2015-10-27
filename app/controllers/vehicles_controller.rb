class VehiclesController < ApplicationController
  def index
    #raise

    scope = Vehicle.approved
    scope = scope.filter_by_make(params[:makes]) if params[:makes].present?
    scope = scope.filter_by_year(params[:years]) if params[:years].present?

    @vehicles = scope
    authorize @vehicles
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @primary_image, @images = @vehicle.primary_and_all_vehicle_images
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

      flash[:notice] = "The Vehicle was sent to the Administrator for Appraval. You will be notified in your Dashboard if your vehicle was approved or denied."
      redirect_to current_user
    else
      flash[:error] = "There was an error saving the Vehicle to the Registry. Please try again."
      render :new
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle
    @primary_image, @images = @vehicle.primary_and_all_vehicle_images
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
      @primary_image, @images = @vehicle.primary_and_all_vehicle_images
      render :edit
    end
  end

  def re_edit
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle
    @primary_image, @images = @vehicle.primary_and_all_vehicle_images
  end

  def resubmit
    #update and new request
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle

    if @vehicle.update_attributes(vehicle_params)
      add_vehicle_images if params[:vehicle][:vehicle_images][:image]

      Vehicle.transaction do
        @vehicle.active_registry_request.archive
        create_registry_request(@vehicle)
      end

      flash[:notice] = "The Vehicle entry was updated and sent to the Administrator. Please wait for Approval."
      redirect_to @vehicle
    else
      flash[:error] = "There was an error updating the Vehicle. Please try again."
      @primary_image, @images = @vehicle.primary_and_all_vehicle_images
      render :re_edit
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :year, :production_date, :engine, :transmission, :trim, :color, :options, :location, :description, vehicle_images_attributes: [:image])
  end

  def add_vehicle_images
    params[:vehicle][:vehicle_images][:image].each_with_index do |img, i|
      image = @vehicle.vehicle_images.build(image: img)
      image.primary = true if i == 0
      image.save!
    end
  end

  def create_registry_request(vehicle)
    RegistryRequest.create!(vehicle: vehicle)
  end

end
