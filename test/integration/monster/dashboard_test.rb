require 'test_helper'

class Monster::DashboardTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'SHOW dashboard' do
    get monster_root_path
    assert_response :success

    assert_select 'h1', text: 'Monster Dashboard'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#options a', 4
  end

  test 'SHOW admin dashboard' do
    get admin_root_path
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', text: 'Monster Dashboard'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#options a', 4
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
