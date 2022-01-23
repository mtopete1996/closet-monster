require 'test_helper'

class Admin::ClothsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'CREATE calendar w valid params' do
    post admin_calendar_path, params: { worn_at: '2020-02-01', cloth_id: white_shirt.id }
    assert_response :redirect
    assert_equal flash[:success], 'Log has been saved successfully'
    assert_equal white_shirt.logs.count, 2
  end

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

  def white_shirt
    @white_shirt ||= cloths(:cloth_white_shirt)
  end

  def setup
    sign_in users(:user_admin)
  end
end
