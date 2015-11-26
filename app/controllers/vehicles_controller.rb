class VehiclesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_vehicle, except: [:index, :new, :create]
    before_action :authorize_vehicle, except: [:index, :new, :create]
    before_action :set_s3_direct_post, only: [:new, :edit, :update, :re_edit]

    def index
        scope = Vehicle.approved
        scope = scope.filter_by_make(params[:makes]) if params[:makes].present?
        scope = scope.filter_by_year(params[:years]) if params[:years].present?

        @vehicles = scope
    end

    def show
    end

    def new
        @vehicle = current_user.vehicles.build
    end

    def create
        @vehicle = current_user.vehicles.build(vehicle_params)

        if @vehicle.save
            add_vehicle_images
            create_registry_request(@vehicle)

            flash[:notice] = 'The Vehicle was sent to the Administrator for approval. You will be notified in your Dashboard if your vehicle was approved or denied.'
            redirect_to current_user
        else
            set_s3_direct_post
            flash[:error] = 'There was an error saving the Vehicle to the Registry. Please try again.'
            render :new
        end
    end

    def edit
    end

    def update
        if @vehicle.update_attributes(vehicle_params)
            add_vehicle_images

            flash[:notice] = 'The Vehicle entry was updated.'
            redirect_to @vehicle
        else
            flash[:error] = 'There was an error updating the Vehicle. Please try again.'
            render :edit
        end
    end

    def re_edit
    end

    def resubmit
        #update and new request
        if @vehicle.update_attributes(vehicle_params)
            add_vehicle_images

            Vehicle.transaction do
                @vehicle.active_registry_request.archive
                create_registry_request(@vehicle)
            end

            flash[:notice] = 'The Vehicle entry was updated and sent to the Administrator. Please wait for Approval.'
            redirect_to @vehicle
        else
            flash[:error] = 'There was an error updating the Vehicle. Please try again.'
            render :re_edit
        end
    end

    private

    def find_vehicle
        @vehicle = Vehicle.find(params.require(:id))
    end

    def vehicle_params
        params.require(:vehicle).permit(:make, :model, :year, :production_date, :engine, :transmission, :trim, :color, :options, :location, :description, vehicle_images_attributes: [:image])
    end

    def add_vehicle_images
        return unless params[:vehicle][:vehicle_images] && params[:vehicle][:vehicle_images].length > 0

        params[:vehicle][:vehicle_images][:image].each_with_index do |img, i|
            image = @vehicle.vehicle_images.build(image: img)
            image.primary = true if i == 0
            image.save!
        end
    end

    def create_registry_request(vehicle)
        RegistryRequest.create!(vehicle: vehicle)
    end

    def set_s3_direct_post
        @s3_direct_post = AWS_BUCKET.presigned_post(key: "uploads/users/#{current_user.id}/vehicle_images/#{SecureRandom.uuid}${filename}", success_action_status: '201', acl: 'public-read')
    end

    def authorize_vehicle
        authorize @vehicle
    end
end
