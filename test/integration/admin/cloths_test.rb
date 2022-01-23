require 'test_helper'

class Admin::ClothsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloths' do
    get admin_cloths_path
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Alicia Sofia'
    assert_select '#cloths-container .cloth', 6
    assert_select '#cloths-table tr', count: 0
  end

  test 'INDEX cloths with per param' do
    get admin_cloths_path(params: { per: 2 })
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Alicia Sofia'
    assert_select '#cloths-container .cloth', 2
  end

  test 'INDEX table view' do
    get admin_cloths_path(params: { view: :table })
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Alicia Sofia'
    assert_select '#cloths-table tr', 6
    assert_select '#cloths-container', count: 0
  end

  test 'NEW cloths' do
    get new_admin_cloth_path
    assert_response :success

    assert_select 'h1', text: 'Create new cloth'
    assert_select 'input#create-other-btn', 1
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth' do
    post admin_cloths_path, params: { cloth: { name: 'TESTING', last_time_worn: Date.yesterday } }
    assert_response :redirect

    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth has been saved successfully', flash[:success]
    assert Cloth.where(name: 'TESTING'), 'Cloth named TESTING should exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloths Section'
  end

  test 'CREATE cloth and create another one' do
    post admin_cloths_path, params: { cloth: { name: 'TESTING', last_time_worn: Date.yesterday },
                                      other: 'Create and add other' }
    assert_response :redirect

    assert_equal 'Cloth has been saved successfully', flash[:success]
    assert Cloth.where(name: 'TESTING'), 'Cloth named TESTING should exist'

    follow_redirect!
    assert_select 'h1', text: 'Create new cloth'
  end

  test 'EDIT cloth' do
    get edit_admin_cloth_path(cloths(:cloth_white_shirt))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth'
    assert_select 'a#delete-cloth-btn', 1
    assert_select 'input#create-other-btn', 0
  end

  test 'UPDATE cloth' do
    put admin_cloth_path(cloths(:cloth_white_shirt)), params: { cloth: { name: 'TESTING',
                                                                         last_time_worn: 3.days.before } }

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth has been updated successfully', flash[:success]
    assert Cloth.where(name: 'TESTING').exists?, 'Cloth named TESTING should exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloths Section'
  end

  test 'DESTROY cloth' do
    delete admin_cloth_path(cloths(:cloth_white_shirt))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth has been deleted successfully', flash[:success]
    assert_not Cloth.where(name: 'testing').exists?, 'Cloth named TESTING should NOT exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloths Section'
  end

  private

  def setup
    sign_in users(:user_admin)
  end
end
