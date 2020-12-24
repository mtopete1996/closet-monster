require 'test_helper'

class Admin::ClothTypesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloth types' do
    get admin_cloth_types_path
    assert_response :success

    assert_select 'h1', text: 'Types of Cloth Section'
    assert_select '#userDropdown', text: 'Porfirio Bayardo'
    assert_select 'table tr', 1
  end

  test 'NEW cloth types' do
    get new_admin_cloth_type_path
    assert_response :success

    assert_select 'h1', text: 'Create new type of cloth'
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth type' do
    post admin_cloth_types_path, params: { cloth_type: { name: :test_type } }
    assert_response :redirect

    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth type has been saved successfully', flash[:success]
    assert ClothType.where(name: :test_type)
  end

  test 'EDIT cloth type' do
    get edit_admin_cloth_type_path(cloth_types(:cloth_type_shirts))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth type'
    assert_select 'a#delete-type-btn', 1
  end

  test 'UPDATE cloth type' do
    params = { cloth_type: { name: :testing } }
    put admin_cloth_type_path(cloth_types(:cloth_type_shirts)), params: params

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth type has been updated successfully', flash[:success]
    assert ClothType.where(name: 'testing').exists?
  end

  test 'DESTROY cloth type' do
    delete admin_cloth_type_path(cloth_types(:cloth_type_shirts))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth type has been deleted successfully', flash[:success]
    assert !ClothType.where(name: 'testing').exists?
  end

  private

  def setup
    sign_in users(:user_admin)
  end
end