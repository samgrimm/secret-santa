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

  scenario "logged in user adds multiple invitations to the party" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @invitee1 = FactoryGirl.create(:user, email: "invitee1@example.com")
    @invitee2 = FactoryGirl.create(:user, email: "invitee2@example.com")
    @invitee3 = FactoryGirl.create(:user, email: "invitee3@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    click_link 'Add Invitees'
    fill_in 'Email', with: "invitee@example.com, invitee1@example.com, invitee2@example.com, invitee3@example.com"
    click_button 'Create Invitation'
    expect(page).to have_css( '.notice', 'You added an invitee to your party')
    expect(Invitation.all.count).to eq(4)
    expect(Invitation.last.user).to eq(@invitee3)
    expect(Invitation.last.party).to eq(@party)
  end

  scenario "logged in user adds multiple invitations with line break separator" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @invitee1 = FactoryGirl.create(:user, email: "invitee1@example.com")
    @invitee2 = FactoryGirl.create(:user, email: "invitee2@example.com")
    @invitee3 = FactoryGirl.create(:user, email: "invitee3@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    click_link 'Add Invitees'
    fill_in 'Email', with: "invitee@example.com\ninvitee1@example.com\ninvitee2@example.com\ninvitee3@example.com"
    click_button 'Create Invitation'
    expect(page).to have_css( '.notice', 'You added an invitee to your party')
    expect(Invitation.all.count).to eq(4)
    expect(Invitation.last.user).to eq(@invitee3)
    expect(Invitation.last.party).to eq(@party)
  end

  scenario "logged in user tries to add repeated addresses" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @invitee1 = FactoryGirl.create(:user, email: "invitee1@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    click_link 'Add Invitees'
    fill_in 'Email', with: "invitee@example.com\ninvitee1@example.com\ninvitee1@example.com\ninvitee@example.com"
    click_button 'Create Invitation'
    expect(page).to have_css( '.notice', 'You added an invitee to your party')
    expect(Invitation.all.count).to eq(2)
    expect(Invitation.last.user).to eq(@invitee1)
    expect(Invitation.last.party).to eq(@party)
  end

  scenario "logged in user adds invitees from gmail contacts" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "newuser@example.com")
    sign_in @user
    @party = FactoryGirl.create(:party, organizer: @user)
    visit party_path(@party)
    OmniContacts.integration_test.enabled = true
    OmniContacts.integration_test.mock(:gmail, [{:email => "contact@example.com"},
                                                {:email => "user@example.com"},
                                                {:email => "another@example.com"}])
    visit '/contacts/gmail'
    page.should have_content("another@example.com")
    check('another@example.com')
    click_button 'Create Invitation'
    page.should have_content("Successfully created invitation.")
    expect(Invitation.all.count).to eq(1)
    expect(Invitation.last.user.email).to eq("another@example.com")
    expect(Invitation.last.party).to eq(@party)
  end
end
