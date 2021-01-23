require 'test_helper'

class UserRegistrationsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'NEW user registration' do
    get new_user_registration_path
    assert_response :success

    assert_select 'h2', text: 'Sign up'
  end

  test 'CREATE user' do
    data = { user: { name: :test, email: 'test@test.test', username: :testing, password: 'testing-123!' } }
    post user_registration_path, params: data
    assert_response :redirect
    follow_redirect!

    assert User.find_by(email: 'test@test.test'), 'A user with email: "test@test.test" should exist'
    assert_select 'h1', text: 'Monster Dashboard'
    assert_select '#userDropdown', text: 'test'
  end

  test 'CREATE user w invalid values' do
    data = { user: { username: :testing, password: 'testing-123!' } }
    post user_registration_path, params: data
    assert_response :success

    assert_select '.alert li', text: "Email can't be blank"
    assert_select '.alert li', text: "Name can't be blank"
    assert_not User.find_by(email: 'test@test.test'), 'A user with email: "test@test.test" should not exist'
  end
end
