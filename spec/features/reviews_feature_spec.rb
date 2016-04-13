require 'rails_helper'

feature 'reviewing' do

  before do
    sign_up_one
    add_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    click_link 'Review KFC'
    fill_in "Thoughts", with: "terrible"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'terrible'
  end

  scenario 'users can only review a restaurant once' do
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    expect(page).to have_content "You cannot review this restaurant more than once"
  end
end
