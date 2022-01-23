require 'test_helper'

class ClothTypeTest < ActiveSupport::TestCase
  test 'CREATE cloth_type w valid name' do
    cloth_type = ClothType.create name: :dress, user: user_monster

    assert_not_nil cloth_type
    assert cloth_type.valid?, 'ClothType have to be valid'
    assert cloth_type.persisted?, 'ClothType have to have persisted'
    assert 'dress', cloth_type.name
  end

  test 'CREATE cloth_type w empty name' do
    cloth_type = ClothType.create name: nil

    assert_not_nil cloth_type
    assert cloth_type.invalid?, 'ClothType have to be invalid'
    assert_not cloth_type.persisted?, 'ClothType have to have not persisted'

    errors = cloth_type.errors.full_messages
    assert_includes errors, "Name can't be blank", 'There have to be an error of name presence'
  end

  test 'CREATE cloth_type w no user' do
    cloth_type = ClothType.create name: 'Manuel'

    assert_not_nil cloth_type
    assert cloth_type.valid?, 'ClothType have to be valid'
    assert cloth_type.persisted?, 'ClothType have to have persisted'
  end

  private

  def user_monster
    @user_monster ||= users(:user_monster)
  end
end
