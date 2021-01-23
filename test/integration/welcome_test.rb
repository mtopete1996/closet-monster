require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest
  test 'SHOW Welcome' do
    get root_path
    assert_response :success

    assert_select 'h1', text: 'Welcome to your closet monster'
    assert_select '#signin-btn', text: 'Sign in'
  end

  test 'SHOW admin dashboard' do
    get admin_root_path
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', text: 'Welcome to your closet monster'
    assert_select '#signin-btn', text: 'Sign in'
  end

  test 'SHOW monster dashboard' do
    get monster_root_path
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', text: 'Welcome to your closet monster'
    assert_select '#signin-btn', text: 'Sign in'
  end
end
