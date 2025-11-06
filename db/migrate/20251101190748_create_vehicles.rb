class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :location
      t.date :available_from
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
