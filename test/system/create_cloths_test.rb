require 'application_system_test_case'

class CreateClothsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'visiting the index' do
    visit monster_cloths_path

    assert_selector 'h1', text: 'Cloths Section'

    click_link 'New cloth'

    fill_in 'cloth_name', with: 'Test pants'
    fill_in 'cloth_last_time_worn', with: '2000-01-01'
    select 'Pants', from: 'cloth_cloth_type_id'
    select '725 Originals', from: 'cloth_cloth_brand_id'

    click_button 'Create Cloth'

    assert_selector '.alert', text: 'Cloth has been saved successfully'
    assert_selector '.cloth', text: 'Test pants'
  end

  private

  def setup
    sign_in users(:user_monster)
  end
end
