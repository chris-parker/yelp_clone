def sign_up_one
  visit '/'
  click_link 'Sign up'
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up_two
  visit '/'
  click_link 'Sign up'
  fill_in('Email', with: 'test2@example.com')
  fill_in('Password', with: 'testtest2')
  fill_in('Password confirmation', with: 'testtest2')
  click_button('Sign up')
end

def add_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end
