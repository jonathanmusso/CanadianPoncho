class RegistryRequestsController < ApplicationController
  def index
    @registry_requests = RegistryRequest.all
  end

  def show
    @registry_request = RegistryRequest.find(params[:id])
  end


end
