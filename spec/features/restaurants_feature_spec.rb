require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up_correctly
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user must be logged in to create restaurants' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end


  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      sign_up_correctly
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      sign_up_correctly
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Subway'
      click_button 'Create Restaurant'
      click_link 'Edit Subway'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end

    before { Restaurant.create name: 'KFC' }

    scenario 'user cannot edit another user\'s restaurant' do
      sign_up_correctly
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).not_to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'You cannot edit another user\'s restaurant.'
    end
  end

  context 'deleting restaurants' do

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up_correctly
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Subway'
      click_button 'Create Restaurant'
      click_link 'Delete Subway'
      expect(page).not_to have_content 'Subway'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    before { Restaurant.create name: 'KFC' }

    scenario 'user cannot delete another user\'s restaurant' do
      sign_up_correctly
      click_link 'Delete KFC'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'You cannot delete another user\'s restaurant.'
    end
  end
end
