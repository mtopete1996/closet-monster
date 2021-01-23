class ClothType < ApplicationRecord
  # Configuration

  # Associations
  belongs_to :user, optional: true

  has_many :cloths, dependent: :nullify

  # Validations
  validates :name, presence: true

  # Scopes

  # Delegates
  delegate :name, :username, to: :user, prefix: true

  # Instance methods

  # Class methods
  class << self
    def user_types(user)
      where(user: user).or(globals)
    end
  end

  # Private methods
  # private
end
