class Cloth < ApplicationRecord
  # Validations
  validates :name, :enabled, presence: true

  validate :last_worn_is_past

  # Instance methods
  def last_worn_is_past
    errors.add(:last_time_worn, 'can not be in the future') if Date.today < last_time_worn
  end
end
