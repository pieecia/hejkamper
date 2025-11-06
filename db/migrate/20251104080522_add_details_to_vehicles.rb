class AddDetailsToVehicles < ActiveRecord::Migration[8.0]
  def change
    add_column :vehicles, :sleeps, :integer
    add_column :vehicles, :beds, :integer
    add_column :vehicles, :length, :decimal
    add_column :vehicles, :year, :integer
    add_column :vehicles, :brand, :string
    add_column :vehicles, :model, :string
    add_column :vehicles, :transmission, :string
    add_column :vehicles, :fuel_type, :string
    add_column :vehicles, :mileage, :integer
    add_column :vehicles, :features, :text
  end
end
