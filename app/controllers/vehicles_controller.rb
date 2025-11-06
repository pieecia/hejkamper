class VehiclesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :require_owner!, except: [ :show ]
  before_action :set_vehicle, only: [ :edit, :update, :destroy ]

  rescue_from ActiveRecord::RecordNotFound, with: :vehicle_not_found

  def index
    @my_vehicles = current_user.vehicles.order(created_at: :desc)
  end

  def new
    @vehicle = current_user.vehicles.build
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def edit

  end

  def create
    @vehicle = current_user.vehicles.build(vehicle_params)

    if @vehicle.save
      redirect_to @vehicle, notice: t(".create.vehicle_created")
    else
      handle_errors(@vehicle, :create)
      render :new, status: :unprocessable_content
    end
  end

  def update
    images = params.dig(:vehicle, :images)
    attributes = vehicle_params.except(:images)

    if @vehicle.update_with_images(attributes, images)
      redirect_to @vehicle, notice: t(".update.vehicle_updated")
    else
      handle_errors(@vehicle, :update)
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @vehicle.destroy
      redirect_to vehicles_path, notice: t(".destroy.vehicle_destroyed")
    else
      redirect_to vehicles_path, alert: t(".destroy.vehicle_destruction_failed")
    end
  end

  private

  def require_owner!
    unless current_user.owner? || current_user.admin?
      redirect_to vehicles_path, alert: t('vehicles.forbidden')
    end
  end

  def set_vehicle
    @vehicle = current_user.vehicles.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(
      :name, :brand, :model, :year, :city, :location,
      :available_from, :price, :description,
      :sleeps, :beds, :length, :transmission, :fuel_type, feature_ids: [], images: []
    )
  end

  def vehicle_not_found
    redirect_to root_path, alert: t('vehicles.not_found')
  end

  def handle_errors(vehicle, action)
    error_message = vehicle.errors.full_messages.to_sentence.presence
    flash.now[:alert] = error_message || t(".#{action}.vehicle_#{action == :create ? 'creation' : 'update'}_failed")
  end
end