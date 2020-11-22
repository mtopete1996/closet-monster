class User < ApplicationRecord
  # Configurations
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[monster admin]

  # Associations
  has_many :clothes

  # Validations
  validates :name, :username, :email, :password, presence: true
end
