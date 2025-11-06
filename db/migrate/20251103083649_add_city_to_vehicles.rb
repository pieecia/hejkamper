class AddCityToVehicles < ActiveRecord::Migration[8.0]
  def change
    add_column :vehicles, :city, :string
    add_index :vehicles, :city
  end
end
