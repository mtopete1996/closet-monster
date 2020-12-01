class User < ApplicationRecord
  # Configurations
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[monster admin]

  # Associations
  has_many :cloths
  has_many :cloth_types

  # Validations
  validates :name, :username, :email, :role, presence: true
  validates :role, inclusion: { in: roles.keys }

  # Scopes

  # Delegates

  # Instance methods

  # Class methods
  # class << self
  # end

  # Private methods
  # private
end
