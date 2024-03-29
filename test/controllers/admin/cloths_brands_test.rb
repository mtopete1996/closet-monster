require 'test_helper'

class Admin::ClothBrandsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloth brands' do
    get admin_cloth_brands_path
    assert_response :success

    assert_select 'h1', text: 'Cloth Brands Section'
    assert_select '#userDropdown', text: 'Alicia Sofia'
    assert_select 'table tr', 3
    assert_select 'td', text: '725 Originals'
    assert_select 'th', text: 'Name'
  end

  test 'NEW cloth brands' do
    get new_admin_cloth_brand_path
    assert_response :success

    assert_select 'h1', text: 'Create new brand of cloth'
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth brand' do
    post admin_cloth_brands_path, params: { cloth_brand: { name: 'Test brand' } }
    assert_response :redirect

    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Cloth brand has been saved successfully', flash[:success]
    assert ClothBrand.where(name: 'Test brand').exists?,
           'Cloth Brand "Test brand" have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloth Brands Section'
  end

  test 'CREATE cloth brand with ajax' do
    post admin_cloth_brands_path, params: { cloth_brand: { name: 'Test brand XHR' } }, xhr: true
    assert_response :success

    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Test brand XHR', ClothBrand.recent.take.name
  end

  test 'EDIT cloth brand' do
    get edit_admin_cloth_brand_path(cloth_brands(:cloth_brand_gap))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth brand'
    assert_select 'a#delete-brand-btn', 1
  end

  test 'UPDATE cloth brand' do
    params = { cloth_brand: { name: 'Testing brand' } }
    put admin_cloth_brand_path(cloth_brands(:cloth_brand_gap)), params: params

    assert_response :redirect
    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Cloth brand has been updated successfully', flash[:success]
    assert ClothBrand.where(name: 'Testing brand').exists?,
           'Cloth Brand "Testing brand" have to exist'

    follow_redirect!
    assert_select 'h1', text: 'Cloth Brands Section'
  end

  test 'DESTROY cloth brand' do
    delete admin_cloth_brand_path(cloth_brands(:cloth_brand_gap))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success have to be present'
    assert_equal 'Cloth brand has been deleted successfully', flash[:success]
    assert_not ClothBrand.where(name: 'GAP').exists?,
               %q(Cloth Brand named "GAP" don't have to exist)

    follow_redirect!
    assert_select 'h1', text: 'Cloth Brands Section'
  end

  private

  def setup
    sign_in users(:user_admin)
  end
end
