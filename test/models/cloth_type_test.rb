require 'test_helper'

class ClothTypeTest < ActiveSupport::TestCase
  test 'CREATE cloth_type w valid name' do
    cloth_type = ClothType.create name: :dress

    assert_not_nil cloth_type
    assert cloth_type.valid?, 'Cloth should be valid'
    assert cloth_type.persisted?, 'ClothType should have persisted'
    assert 'dress', cloth_type.name
  end

  test 'CREATE cloth_type w empty name' do
    cloth_type = ClothType.create name: nil

    assert_not_nil cloth_type
    assert cloth_type.invalid?, 'Cloth should be invalid'
    assert_not cloth_type.persisted?, 'ClothType should have not persisted'
  end
end
