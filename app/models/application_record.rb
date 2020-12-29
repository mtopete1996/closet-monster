class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Scopes
  scope :globals, -> { where(user_id: nil) }
  scope :alphabetically, -> { order('LOWER(name)') }
end
