class Cloth < ApplicationRecord
  # Active Storage
  has_one_attached :picture

  # Associations
  belongs_to :user

  # Validations
  validates :name, :enabled, :last_time_worn, presence: true

  validate :last_worn_is_past

  # Instance methods
  def last_worn_is_past
    return if last_time_worn.blank?

    errors.add(:last_time_worn, 'can not be in the future') if Date.today < last_time_worn
  end
end
