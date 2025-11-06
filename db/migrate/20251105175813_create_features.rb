class CreateFeatures < ActiveRecord::Migration[8.0]
  def change
    create_table :features do |t|
      t.string :key, null: false
      t.integer :position, default: 0

      t.timestamps
    end
    add_index :features, :key, unique: true
  end
end
