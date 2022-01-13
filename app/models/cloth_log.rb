class ClothLog < ApplicationRecord
  # Configuration

  # Associations
  belongs_to :cloth

  has_one :user, through: :cloth

  # Validations
  validates :worn_at, presence: true

  # Scopes

  # Delegates
  delegate :id, :name, to: :cloth, prefix: true

  # Instance methods

  # Class methods

  # Private methods
  # private
end
