require 'test_helper'

class ClothLogTest < ActiveSupport::TestCase
  test 'CREATE log with valid parameters' do
    log = ClothLog.new(worn_at: DateTime.current, cloth: cloths(:cloth_brown_shirt))
    assert log.valid?, 'Log should be valid'
    assert log.save, 'Log should have been saved'
  end

  test 'CREATE log without the timestamp' do
    log = ClothLog.new(cloth: cloths(:cloth_brown_shirt))
    assert log.invalid?, 'Log should be invalid'
    assert_equal(log.errors.full_messages, ["Worn at can't be blank"])
  end

  test 'CREATE log without a cloth' do
    log = ClothLog.new(worn_at: DateTime.current)
    assert log.invalid?, 'Log should be invalid'
    assert_equal(log.errors.full_messages, ['Cloth must exist'])
  end
end
