class RemoveMileageFromVehicles < ActiveRecord::Migration[8.0]
  def change
    remove_column :vehicles, :mileage, :integer
  end
end
