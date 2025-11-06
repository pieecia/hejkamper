class AddOwnerToVehicles < ActiveRecord::Migration[8.0]
  def up
    add_reference :vehicles, :owner, foreign_key: { to_table: :users }, index: true unless column_exists?(:vehicles, :owner_id)

    # Find an existing owner or create a placeholder owner
    owner = User.owner.first || User.create!(
      email: "default-owner@hejkamper.pl",
      password: "password123",
      role: :owner
    )

    Vehicle.where(owner_id: nil).update_all(owner_id: owner.id)

    change_column_null :vehicles, :owner_id, false
  end

  def down
    remove_reference :vehicles, :owner, foreign_key: true if column_exists?(:vehicles, :owner_id)
  end
end
