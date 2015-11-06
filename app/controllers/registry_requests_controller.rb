class RegistryRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_registry_request, except: [:index]
    before_action :authorize_registry_request

    def index
        @registry_requests = RegistryRequest.pending
    end

    def show
    end

    def update
        if params[:commit] == "Approve"
            @registry_request.approved_at = Time.now
            flash_message = "The vehicle was approved for the Registry."
        elsif params[:commit] == "Deny"
            @registry_request.denied_at = Time.now
            flash_message = "The vehicle was denied."
        end

        @registry_request.notes = params[:registry_request][:notes]
        # @request.notes = params.require(:registry_request).permit(:notes)

        if @registry_request.save
            flash[:notice] = flash_message
        else
            flash[:error] = "There was an error approving the ehicle. Please try again."
        end

        redirect_to registry_requests_path
    end

    private
    def find_registry_request
        @registry_request = RegistryRequest.find(params.require(:id))
    end

    def authorize_registry_request
        authorize @registry_request
    end
end
