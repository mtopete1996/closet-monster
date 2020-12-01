require 'test_helper'

class ClothTest < ActiveSupport::TestCase
  test 'CREATE cloth w valid data' do
    data = { name: :my_tshirt, last_time_worn: Date.yesterday, user: users(:user_admin) }
    cloth = Cloth.create data

    assert_not_nil cloth
    assert cloth.valid?, 'Cloth should be valid'
    assert 'my tshirt', cloth.name
    assert Date.yesterday, cloth.last_time_worn
  end

  test 'CREATE cloth w nil name' do
    data = { last_time_worn: Date.yesterday }
    cloth = Cloth.create data

    assert cloth.invalid?, 'Cloth should be invalid'
    assert_not cloth.persisted?, 'Cloth should not have persisted'
    assert_includes cloth.errors.full_messages, "Name can't be blank",
                    'There should be an error of name presence'
  end

  test 'CREATE cloth w last_worn is future' do
    data = { name: :the_tshirt, last_time_worn: Date.tomorrow }
    cloth = Cloth.create data

    assert cloth.invalid?, 'Cloth should be invalid'
    assert_not cloth.save, 'Cloth should not be saved'

    errors = cloth.errors.full_messages
    assert_includes errors, 'User must exist', 'There should be an error of user existance'
    assert_includes errors, 'Last time worn can not be in the future',
                    'There should be an error wrong date'
  end
end
