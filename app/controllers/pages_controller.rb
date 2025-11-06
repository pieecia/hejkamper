class PagesController < ApplicationController
  def home
    @recent_vehicles = Vehicle.recently_added
  end
end
