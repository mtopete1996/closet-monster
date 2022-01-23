require 'test_helper'

class Monster::ClothsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloths' do
    get monster_cloths_path
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#cloths-container .cloth', 2
    assert_select '#cloths-table tr', count: 0
  end

  test 'INDEX cloths with per param' do
    get monster_cloths_path(params: { per: 2 })
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#cloths-container .cloth', 2
  end

  test 'INDEX table view' do
    get monster_cloths_path(params: { view: :table })
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#cloths-table tr', 2
    assert_select '#cloths-container', count: 0
  end

  test 'NEW cloths' do
    get new_monster_cloth_path
    assert_response :success

    assert_select 'h1', text: 'Create new cloth'
    assert_select 'input#create-other-btn', 1
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth' do
    params = { cloth: { name: 'Testing cloth', last_time_worn: Date.yesterday } }
    post monster_cloths_path, params: params
    assert_response :redirect

    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Cloth has been saved successfully', flash[:success]
    assert Cloth.where(name: 'Testing cloth'), 'Cloth named Testing cloth have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloths Section'
  end

  test 'CREATE cloth and create another one' do
    params = { cloth: { name: 'Testing cloth', last_time_worn: Date.yesterday },
               other: 'Create and add other' }
    post monster_cloths_path, params: params
    assert_response :redirect

    assert_equal 'Cloth has been saved successfully', flash[:success]
    assert Cloth.where(name: 'Testing cloth'), 'Cloth named Testing cloth have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Create new cloth'
  end

  test 'EDIT cloth' do
    get edit_monster_cloth_path(cloths(:cloth_white_shirt))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth'
    assert_select 'a#delete-cloth-btn', 1
    assert_select 'input#create-other-btn', 0
  end

  test 'UPDATE cloth' do
    params = { cloth: { name: 'Testing cloth', last_time_worn: 3.days.before } }
    put monster_cloth_path(cloths(:cloth_white_shirt)), params: params

    assert_response :redirect
    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Cloth has been updated successfully', flash[:success]
    assert Cloth.where(name: 'Testing cloth').exists?, 'Cloth named Testing cloth have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloths Section'
  end

  test 'DESTROY cloth' do
    delete monster_cloth_path(cloths(:cloth_white_shirt))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Cloth has been deleted successfully', flash[:success]
    assert_not Cloth.where(name: 'The White Shirt').exists?,
               %q(Cloth named "The White Shirt" cloth don't have to exist)

    follow_redirect!
    assert_select 'h1', text: 'Cloths Section'
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
