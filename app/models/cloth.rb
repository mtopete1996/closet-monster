class Cloth < ApplicationRecord
  # Configuration
  has_one_attached :picture

  VALID_FILTERS = %i[brand name last_time_worn type].freeze

  # Associations
  belongs_to :brand, class_name: 'ClothBrand', optional: true, foreign_key: :cloth_brand_id
  belongs_to :type, class_name: 'ClothType', optional: true, foreign_key: :cloth_type_id
  belongs_to :user

  # Validations
  validates :name, :enabled, presence: true
  validates :picture, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  validate :last_worn_is_past

  # Scopes
  scope :by_brand, -> { left_outer_joins(:brand).non_sensitive_order('cloth_brands.name') }
  scope :by_last_time_worn, -> { order(last_time_worn: :asc) }
  scope :by_type, -> { left_outer_joins(:type).non_sensitive_order('cloth_types.name') }
  scope :with_data, -> { includes(:brand, :type) }
  scope :with_user, -> { includes(:user) }

  # Delegates
  delegate :name, to: :brand, prefix: true
  delegate :name, to: :type, prefix: true
  delegate :name, :username, to: :user, prefix: true

  # Instance methods
  def last_worn_is_past
    return if last_time_worn.blank?

    errors.add(:last_time_worn, 'can not be in the future') if Date.today < last_time_worn
  end

  # Class methods
  class << self
    def order_by(sentence)
      return by_name if sentence.blank?

      send("by_#{sentence}")
    end
  end

  # Private methods
  # private
end
