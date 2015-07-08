class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(params.require(:vehicle).permit(:make, :model, :year, :production_date, :engine, :transmission, :trim, :color, :options, :location, :description))
    @vehicle.user = current_user
    
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
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update_attributes(params.require(:vehicle).permit(:make, :model, :year, :production_date, :engine, :transmission, :trim, :color, :options, :location, :description))
      flash[:notice] = "The Vehicle entry was updated."
      redirect_to @vehicle
    else
      flash[:error] = "There was an error updating the Vehicle. Please try again."
      render :edit
    end
  end
end
