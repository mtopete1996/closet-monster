class ClothType < ApplicationRecord
  # Configuration

  # Associations
  belongs_to :user, optional: true

  has_many :cloths

  # Validations
  validates :name, presence: true

  # Scopes

  # Delegates

  # Instance methods

  # Class methods
  class << self
    def user_types(user)
      where(user: user).or(where(user_id: nil))
    end
  end

  # Private methods
  # private
end
