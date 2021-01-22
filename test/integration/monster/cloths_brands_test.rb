require 'test_helper'

class Monster::ClothBrandsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloth brands' do
    get monster_cloth_brands_path
    assert_response :success

    assert_select 'h1', text: 'Cloth Brands Section'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select 'table tr', 2
  end

  test 'NEW cloth brands' do
    get new_monster_cloth_brand_path
    assert_response :success

    assert_select 'h1', text: 'Create new brand of cloth'
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth brand' do
    post monster_cloth_brands_path, params: { cloth_brand: { name: :test_brand } }
    assert_response :redirect

    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth brand has been saved successfully', flash[:success]
    assert ClothBrand.where(name: :test_brand)

    follow_redirect!
    assert_select 'h1', text: 'Cloth Brands Section'
  end

  test 'CREATE cloth brand with ajax' do
    post monster_cloth_brands_path, params: { cloth_brand: { name: :test_brand_xhr } }, xhr: true
    assert_response :success

    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'test_brand_xhr', ClothBrand.recent.take.name
  end

  test 'EDIT cloth brand' do
    get edit_monster_cloth_brand_path(cloth_brands(:cloth_brand_levis))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth brand'
    assert_select 'a#delete-brand-btn', 1
  end

  test 'UPDATE cloth brand' do
    params = { cloth_brand: { name: :testing } }
    put monster_cloth_brand_path(cloth_brands(:cloth_brand_levis)), params: params

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth brand has been updated successfully', flash[:success]
    assert ClothBrand.where(name: 'testing').exists?

    follow_redirect!
    assert_select 'h1', text: 'Cloth Brands Section'
  end

  test 'DESTROY cloth brand' do
    delete monster_cloth_brand_path(cloth_brands(:cloth_brand_levis))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth brand has been deleted successfully', flash[:success]
    assert !ClothBrand.where(name: 'testing').exists?

    follow_redirect!
    assert_select 'h1', text: 'Cloth Brands Section'
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
