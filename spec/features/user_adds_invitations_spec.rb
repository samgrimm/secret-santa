require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "UserAddsInvitations", :type => :feature do
  scenario "Logged in user adds one invitation to existing user" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    click_link 'Add Invitees'
    fill_in 'Email', with: "invitee@example.com"
    click_button 'Create Invitation'
    expect(page).to have_css( '.notice', 'You added an invitee to your party')
    expect(Invitation.all.count).to eq(1)
    expect(Invitation.last.user).to eq(@invitee)
    expect(Invitation.last.party).to eq(@party)
  end

  scenario "Logged in user adds one invitation to new user" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    click_link 'Add Invitees'
    fill_in 'Email', with: "invitee@example.com"
    click_button 'Create Invitation'
    expect(page).to have_css( '.notice', 'You added an invitee to your party')
    expect(Invitation.all.count).to eq(1)
    expect(User.last.email).to eq("invitee@example.com")
    expect(Invitation.last.user.email).to eq("invitee@example.com")
    expect(Invitation.last.party).to eq(@party)
  end

  scenario "logged in user adds invitation from gmail addresses" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    click_link 'Add Invitees'
  end
end
