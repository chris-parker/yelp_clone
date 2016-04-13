require 'rails_helper'

feature 'user can sign in and out' do
  context 'user not signed in and on the homepage' do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    it "should not see 'sign out' link" do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'user signed in on the homepage' do
    before do
      sign_up_one
    end

    it "should see 'sign out' link" do
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit '/'
      expect(page).not_to have_content 'Sign in'
      expect(page).not_to have_content 'Sign up'
    end

    it "does not allow a user to edit/delete restaurant if created by another user" do
      add_restaurant
      click_link 'Sign out'
      sign_up_two
      click_link "Delete KFC"
      expect(page).to have_content "Users cannot delete another user's restaurant"
    end
  end
end
