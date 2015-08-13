class RegistryRequestsController < ApplicationController
  def index
    @registry_requests = RegistryRequest.pending
  end

  def show
    @registry_request = RegistryRequest.find(params[:id])
  end

  def update
    @request = RegistryRequest.find(params[:id])

    if params[:commit] == "Approve"
      @request.approved_at = Time.now
      flash_message = "The vehicle was approved for the Registry."
    elsif params[:commit] == "Deny"
      @request.denied_at = Time.now
      flash_message = "The vehicle was denied."
    end

    @request.notes = params.require(:registry_request).permit(:notes)
    
    if @request.save
      flash[:notice] = flash_message
    else
      flash[:error] = "There was an error approving the ehicle. Please try again."
    end

    redirect_to registry_requests_path
  end
end
