require 'test_helper'

class Monster::ClothTypesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloth types' do
    get monster_cloth_types_path
    assert_response :success

    assert_select 'h1', text: 'Types of Cloth Section'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select 'table tr', 2
    assert_select 'td', text: 'Pants'
    assert_select 'td', text: 'Socks', count: 0
    assert_select 'th', text: 'User', count: 0
  end

  test 'NEW cloth types' do
    get new_monster_cloth_type_path
    assert_response :success

    assert_select 'h1', text: 'Create new type of cloth'
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth type' do
    post monster_cloth_types_path, params: { cloth_type: { name: 'Test type' } }
    assert_response :redirect

    assert flash[:success].present?, 'A flash success have to exist'
    assert_equal 'Cloth type has been saved successfully', flash[:success]
    assert ClothType.where(name: 'Test type').exists?,
           'Cloth type "Test type" have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Types of Cloth Section'
  end

  test 'EDIT cloth type' do
    get edit_monster_cloth_type_path(cloth_types(:cloth_type_shirts))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth type'
    assert_select 'a#delete-type-btn', 1
  end

  test 'UPDATE cloth type' do
    params = { cloth_type: { name: 'Testing type' } }
    put monster_cloth_type_path(cloth_types(:cloth_type_shirts)), params: params

    assert_response :redirect
    assert flash[:success].present?, 'A flash success have to exist'
    assert_equal 'Cloth type has been updated successfully', flash[:success]
    assert ClothType.where(name: 'Testing type').exists?,
           'Cloth type "Test type" have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Types of Cloth Section'
  end

  test 'DESTROY cloth type' do
    delete monster_cloth_type_path(cloth_types(:cloth_type_shirts))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success have to exist'
    assert_equal 'Cloth type has been deleted successfully', flash[:success]
    assert_not ClothType.where(name: 'Shirts').exists?,
               %q(Cloth Brand named "Shirts" don't have to exist)

    follow_redirect!
    assert_select 'h1', text: 'Types of Cloth Section'
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
