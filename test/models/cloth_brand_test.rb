require 'test_helper'

class ClothBrandTest < ActiveSupport::TestCase
  test 'CREATE cloth_brand w valid name' do
    cloth_brand = ClothBrand.create name: 'Springfield', user: user_monster

    assert_not_nil cloth_brand
    assert cloth_brand.valid?, 'ClothBrand have to be valid'
    assert cloth_brand.persisted?, 'ClothBrand have to have persisted'
    assert 'Springfield', cloth_brand.name
  end

  test 'CREATE cloth_brand w empty name' do
    cloth_brand = ClothBrand.create name: nil

    assert_not_nil cloth_brand
    assert cloth_brand.invalid?, 'ClothBrand have to be invalid'
    assert_not cloth_brand.persisted?, 'ClothBrand have to have not persisted'

    errors = cloth_brand.errors.full_messages
    assert_includes errors, "Name can't be blank", 'There have to be an error of name presence'
  end

  test 'CREATE cloth_brand w no user' do
    cloth_brand = ClothBrand.create name: 'Manuel'

    assert_not_nil cloth_brand
    assert cloth_brand.valid?, 'ClothBrand have to be valid'
    assert cloth_brand.persisted?, 'ClothBrand have to have persisted'
  end

  private

  def user_monster
    @user_monster ||= users(:user_monster)
  end
end
