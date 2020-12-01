class ClothType < ApplicationRecord
  # Configuration

  # Associations
  belongs_to :user
  has_many :cloths

  # Validations
  validates :name, presence: true

  # Scopes

  # Delegates

  # Instance methods

  # Class methods
  # class << self
  # end

  # Private methods
  # private
end
