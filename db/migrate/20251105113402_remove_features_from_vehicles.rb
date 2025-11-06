class RemoveFeaturesFromVehicles < ActiveRecord::Migration[8.0]
  def change
    remove_column :vehicles, :features, :text
  end
end
