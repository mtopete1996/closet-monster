require 'test_helper'

class Admin::WelcomeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'SHOW Welcome' do
    get root_path
    assert_response :success

    assert_select 'h1', text: 'Welcome to your closet monster'
    assert_select '#userDropdown', text: 'Alicia Sofia'
  end

  private

  def setup
    sign_in users(:user_admin)
  end
end
