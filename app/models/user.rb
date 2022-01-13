class User < ApplicationRecord
  # Configurations
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[monster admin]

  # CallBacks
  before_validation :assign_role

  # Associations
  has_many :cloths
  has_many :cloth_types
  has_many :cloth_brands
  has_many :cloth_logs, through: :cloths, source: :logs

  # Validations
  validates :name, :username, :email, :role, presence: true
  validates :role, inclusion: { in: roles.keys }

  # Scopes

  # Delegates

  # Instance methods

  # Class methods
  # class << self
  # end

  # Private methods
  private

  def assign_role
    self.role = :monster if role.blank?
  end
end
