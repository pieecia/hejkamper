class ListingsController < ApplicationController
  def index
    unless params[:date].present? && params[:city].present?
      redirect_to root_path, alert: t(".missing_params") and return
    end

    begin
      date = Date.parse(params[:date].to_s)

      if date < Date.today
        redirect_to root_path, alert: t(".date_in_past") and return
      end

      @search_params = search_params
      @vehicles = Vehicle.search(search_params)

      @vehicles_map_json = @vehicles.map do |v|
        {
          id: v.id,
          name: v.name,
          latitude: v.latitude.to_f,
          longitude: v.longitude.to_f,
          url: vehicle_path(v)
        }
      end.to_json

    rescue ArgumentError
      redirect_to root_path, alert: t(".invalid_date_format")
    end
  end

  private

  def search_params
    params.permit(:date, :city)
  end
end