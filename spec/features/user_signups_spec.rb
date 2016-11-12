require 'rails_helper'

feature "UserSignups", :type => :feature do
  scenario 'user navigates to signup page' do
    visit root_path
    expect(page).to have_link('Sign Up')
    click_link 'Sign Up'
    expect(page).to have_button('Sign up')
  end

  scenario 'user successfully creates new account' do
    visit new_user_registration_path
    fill_in 'Email', with: 'testy@mcstester.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_button 'Sign up'
    expect(page).to have_css( '.notice', 'Welcome to The Gift Exchange')
    expect(User.all.count).to eq(1)
  end

  scenario 'user is unable to create an account' do
    visit new_user_registration_path
    fill_in 'Email', with: 'testy@mcstester'
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: '1'
    click_button 'Sign up'
    expect(page).to have_css('.alert', 'Password cannot be blank')
    expect(page).to have_css( '.alert', 'Password confirmation does not match')
    expect(page).to have_css( '.alert', 'Email is not correct')
    expect(User.all.count).to eq(0)
  end

  # scenario 'user logs in with facebook' do -- need to figure out how to test it.
  #   visit new_user_registration_path
  #   click_link('Sign up with Facebook')
  #   expect(page).to have_css( '.notice', 'Welcome to The Gift Exchange')
  #   expect(User.all.count).to eq(1)
  # end
end
