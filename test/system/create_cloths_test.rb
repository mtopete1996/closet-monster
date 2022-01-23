require 'application_system_test_case'

class CreateClothsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'visiting the index' do
    Timecop.freeze('2020-01-05') do
      visit monster_cloths_path

      assert_selector 'h1', text: 'Cloths Section'

      click_link 'New cloth'

      fill_in 'cloth_name', with: 'Test pants'
      fill_in 'cloth_worn_at', with: '01/01/2020'
      select 'Pants', from: 'cloth_cloth_type_id'
      select '725 Originals', from: 'cloth_cloth_brand_id'

      click_button 'Create Cloth'

      assert_selector '.alert', text: 'Cloth has been saved successfully'
      assert_selector '.cloth', text: 'Test pants'

      visit monster_calendar_path

      assert_selector '#date-2020-01-01+.cloth-name', text: 'Test pants'
    end
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
