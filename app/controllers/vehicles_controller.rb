class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
    authorize @vehicles
  end

  def show
    @vehicle = Vehicle.find(params[:id])
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
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle
    
    if @vehicle.update_attributes(vehicle_params)
      flash[:notice] = "The Vehicle entry was updated."
      redirect_to @vehicle
    else
      flash[:error] = "There was an error updating the Vehicle. Please try again."
      render :edit
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :year, :production_date, :engine, :transmission, :trim, :color, :options, :location, :description)
  end
end
