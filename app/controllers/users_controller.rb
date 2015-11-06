class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @registry_requests = RegistryRequest.pending
        @vehicles_approved = @user.vehicles.approved
        @vehicles_pending = @user.vehicles.pending
        @vehicles_denied = @user.vehicles.denied
    end

    def update
        if current_user.update_attributes(user_params)
            flash[:notice] = "User information updated."
            redirect_to edit_user_registration_path
        else
            flash[:error] = "Invalid user information."
            redirect_to edit_user_registration_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:name)
    end
end
