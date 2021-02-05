require 'test_helper'

class Monster::ClothsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'INDEX cloths' do
    get monster_cloths_path
    assert_response :success

    assert_select 'h1', text: 'Cloths Section'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#cloths-container a', 4
  end

  test 'NEW cloths' do
    get new_monster_cloth_path
    assert_response :success

    assert_select 'h1', text: 'Create new cloth'
    assert_select 'input#create-other-btn', 1
    assert_select 'input#delete-other-btn', 0
  end

  test 'CREATE cloth' do
    post monster_cloths_path, params: { cloth: { name: :my_tshirt, last_time_worn: Date.yesterday } }
    assert_response :redirect

    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth has been saved successfully', flash[:success]
    assert Cloth.where(name: :my_tshirt)
  end

  test 'CREATE cloth and create another one' do
    post monster_cloths_path, params: { cloth: { name: :my_tshirt, last_time_worn: Date.yesterday },
                                        other: 'Create and add other' }
    assert_response :redirect

    assert_equal 'Cloth has been saved successfully', flash[:success]
    assert Cloth.where(name: :my_tshirt)

    follow_redirect!

    assert_select 'h1', text: 'Create new cloth'
  end

  test 'CREATE cloth with wrong params' do
    post monster_cloths_path, params: { cloth: { last_time_worn: 2.days.from_now } }
    assert_response :success

    assert_select '.alert li', text: "Name can't be blank"
    assert_select '.alert li', text: 'Last time worn can not be in the future'
  end

  test 'EDIT cloth' do
    get edit_monster_cloth_path(cloths(:cloth_white_shirt))
    assert_response :success

    assert_select 'h1', text: 'Edit cloth'
    assert_select 'a#delete-cloth-btn', 1
    assert_select 'input#create-other-btn', 0
  end

  test 'UPDATE cloth' do
    put monster_cloth_path(cloths(:cloth_white_shirt)),
        params: { cloth: { name: :testing, last_time_worn: 3.days.before } }

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth has been updated successfully', flash[:success]
    assert Cloth.where(name: 'testing').exists?
  end

  test 'DESTROY cloth' do
    delete monster_cloth_path(cloths(:cloth_white_shirt))

    assert_response :redirect
    assert flash[:success].present?, 'A flash success should exist'
    assert_equal 'Cloth has been deleted successfully', flash[:success]
    assert !Cloth.where(name: 'testing').exists?
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
