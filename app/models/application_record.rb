class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Scopes
  scope :non_sensitive_order, ->(col_name) { order("LOWER(#{col_name})") }
  scope :alphabetically, -> { non_sensitive_order(:name) }
  scope :globals, -> { where(user_id: nil) }
  scope :recent, -> { order(id: :desc) }
end
