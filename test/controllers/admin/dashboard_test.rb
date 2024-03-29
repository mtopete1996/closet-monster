require 'test_helper'

class Admin::DashboardTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'SHOW dashboard' do
    get admin_root_path
    assert_response :success

    assert_select 'h1', text: 'Admin Dashboard'
    assert_select '#userDropdown', text: 'Alicia Sofia'
    assert_select '#options a', 4
  end

  private

  def setup
    sign_in users(:user_admin)
  end
end
