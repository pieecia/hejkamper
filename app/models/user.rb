class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { renter: 0, owner: 1, admin: 2 }

  has_many :vehicles, foreign_key: :owner_id, inverse_of: :owner

  has_one_attached :avatar

  validate :admin_role_can_be_assigned_only_by_admin, on: :create

  private

  def admin_role_can_be_assigned_only_by_admin
    if admin?
      errors.add(:role, "can only be assigned by an admin user")
    end
  end
end
