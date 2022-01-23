require 'test_helper'

class Admin::ClothsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'SHOW calendar' do
    get admin_calendar_path, params: { start_date: '2020-11-01'.to_date }
    assert_response :success

    assert_select 'h1', text: 'Calendar'
    assert_select '#userDropdown', text: 'Alicia Sofia'
    assert_select '#calendar'
    assert_select '.cloth-name', count: 4

    assert_select '#date-2020-11-12+.cloth-name', text: 'The White Shirt'
    assert_select '#date-2020-11-12+.cloth-name+.cloth-name', text: 'Black Pants'
    assert_select '#date-2020-11-15+.cloth-name', text: 'Black Pants'
    assert_select '#date-2020-11-16+.cloth-name', text: 'Black Pants'
  end

  private

  def setup
    sign_in users(:user_admin)
  end
end
