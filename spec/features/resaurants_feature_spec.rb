require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added do' do
    scenario 'should display a prompt to add a resaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurant yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
