class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :globals, -> { where(user_id: nil) }
end
