require 'test_helper'

class ClothTest < ActiveSupport::TestCase
  test 'CREATE cloth w valid data' do
    data = { name: :my_tshirt, last_time_worn: Date.yesterday, user: user(:user_admin) }
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
    assert_not cloth.save, 'Cloth should not be saved'
  end

  test 'CREATE cloth w last_worn is future' do
    data = { name: :the_tshirt, last_time_worn: Date.tomorrow }
    cloth = Cloth.create data

    assert cloth.invalid?, 'Cloth should be invalid'
    assert_not cloth.save, 'Cloth should not be saved'
  end
end
