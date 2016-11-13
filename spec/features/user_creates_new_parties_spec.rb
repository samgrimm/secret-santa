require 'rails_helper'

feature "UserCreatesNewParties", :type => :feature do
  scenario 'logged in user creates a new party' do
    @user = FactoryGirl.create(:user)
    sign_in @user
    visit new_party_path
    fill_in 'Theme', with: "New Year's Eve"
    select '2016',   :from => "party_date_1i"
    select 'December',   :from => "party_date_2i"
    select '31',   :from => "party_date_3i"
    select '22',   :from => "party_time_4i"
    select '30',   :from => "party_time_5i"
    fill_in 'Address', with: "3609 Bayton Dr, Austin, TX, 78738"
    select '2016',   :from => "party_rsvp_deadline_1i"
    select 'December',   :from => "party_rsvp_deadline_2i"
    select '15',   :from => "party_rsvp_deadline_3i"
    click_button 'Create Party'
    expect(page).to have_css( '.notice', 'You have created a new party')
    expect(Party.all.count).to eq(1)
    expect(Party.last.theme).to eq("New Year's Eve")
    expect(Party.last.user).to eq(@user)
  end

  scenario 'logged in user creates a new party' do
    @user = FactoryGirl.create(:user)
    visit new_party_path
    expect(page).to have_css( '.alert', 'You must login to create a party')
    expect(Party.all.count).to eq(0)
  end
end
