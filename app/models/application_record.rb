class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Scopes
  scope :alphabetically, -> { order('LOWER(name)') }
  scope :globals, -> { where(user_id: nil) }
  scope :recent, -> { order(id: :desc) }
end
