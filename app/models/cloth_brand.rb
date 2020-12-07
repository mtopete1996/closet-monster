class ClothBrand < ApplicationRecord
  # Configuration

  # Associations
  belongs_to :user, optional: true

  has_many :cloths, dependent: :nullify

  # Validations
  validates :name, presence: true

  # Scopes

  # Delegates

  # Instance methods

  # Class methods
  class << self
    def user_brands(user)
      where(user: user)
    end
  end

  # Private methods
  # private
end
