require 'test_helper'

class Monster::ClothsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'SHOW calendar' do
    get monster_calendar_path, params: { start_date: '2021-11-01'.to_date }
    assert_response :success

    assert_select 'h1', text: 'Calendar'
    assert_select '#userDropdown', text: 'Manuel Topete'
    assert_select '#calendar'
    assert_select '.cloth-name', count: 2

    assert_select '#date-2021-11-03+.cloth-name', text: 'Blue pants'
    assert_select '#date-2021-11-16+.cloth-name', text: 'Brown Shirt'
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
