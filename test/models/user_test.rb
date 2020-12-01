require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'CREATE user w valid data' do
    data = { name: :mr_test, username: :test_mr, email: 'mr_test@testing.com', password: :$eCrEt123, role: :admin }
    user = User.create data

    assert_not_nil user
    assert user.valid?, 'User should be valid'
    assert 'mr test', user.name
    assert 'test_mr', user.username
    assert 'mr_test@testing.com', user.email
  end

  test 'CREATE user w nil name' do
    data = { username: :test_mr, email: 'mr_test@testing.com', password: :$eCrEt123, role: :monster }
    user = User.new data

    assert_not_nil user
    assert user.invalid?, 'User should be invalid'
    assert_not user.save, 'User should not be saved'
  end

  test 'CREATE user w nil email' do
    data = { name: :mr_test, username: :test_mr, password: :$eCrEt123, role: :monster }
    user = User.new data

    assert_not_nil user
    assert user.invalid?, 'User should be invalid'
    assert_not user.save, 'User should not be saved'
  end
end
