require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = ENV['DRIVER']&.to_sym || :headless_firefox

  driven_by :selenium, using: DRIVER, screen_size: [1400, 1400]
end
