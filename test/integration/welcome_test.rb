require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest
  test 'SHOW Welcome' do
    get root_path
    assert_response :success

    assert_select 'h1', text: 'Welcome to your closet monster'
    assert_select '#login-btn', text: 'Sign in'
  end
end
