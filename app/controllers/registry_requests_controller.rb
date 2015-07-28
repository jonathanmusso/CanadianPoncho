class RegistryRequestsController < ApplicationController
  def index
    @registry_requests = RegistryRequest.pending
  end

  def show
    @registry_request = RegistryRequest.find(params[:id])
  end

  def approve
    @approval = RegistryRequest.find(params[:id])
    
    if @approval.update_attribute(:approved_at, Time.now)
      flash[:notice] = "The vehicle was approved for the Registry."
      redirect_to request.referer
    else
      flash[:error] = "There was an error approving the vehicle. Please try again."
    end
  end

  def deny
    @denied = RegistryRequest.find(params[:id])

    if @denied.update_attribute(:denied_at, Time.now)
      flash[:notice] = "The vehicle was denied."
      redirect_to request.referer
    else
      flash[:error] = "There was an error denying the vehicle. Please try again."
    end
  end
end
