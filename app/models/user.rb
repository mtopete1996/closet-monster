class User < ApplicationRecord
  # Configurations
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[monster admin]

  # CallBacks

  # Associations
  has_many :cloths
  has_many :cloth_types
  has_many :cloth_brands

  # Validations
  validates :name, :username, :email, presence: true
  validates :role, inclusion: { in: roles.keys }

  # Scopes

  # Delegates

  # Instance methods
  def opposite_role
    return :monster if role.admin?

    :admin
  end

  # Class methods
  # class << self
  # end

  # Private methods
  # private
end
