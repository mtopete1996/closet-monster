class User < ApplicationRecord
  # Configurations
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[monster admin]

  # Associations
  has_many :cloths

  # Validations
  validates :name, :username, :email, :role, presence: true
  validates :role, inclusion: { in: roles.keys }
end
