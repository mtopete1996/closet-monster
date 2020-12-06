class Cloth < ApplicationRecord
  # Configuration
  has_one_attached :picture

  # Associations
  belongs_to :user
  belongs_to :cloth_type, optional: true
  belongs_to :cloth_brand, optional: true

  # Validations
  validates :name, :enabled, presence: true
  validates :picture, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  validate :last_worn_is_past

  # Scopes
  scope :by_last_time_worn, -> { order(last_time_worn: :asc) }

  # Delegates

  # Instance methods
  def last_worn_is_past
    return if last_time_worn.blank?

    errors.add(:last_time_worn, 'can not be in the future') if Date.today < last_time_worn
  end

  # Class methods
  # class << self
  # end

  # Private methods
  # private
end
