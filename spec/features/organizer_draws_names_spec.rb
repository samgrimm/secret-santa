require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "OrganizerDrawsNames", :type => :feature do
  scenario "Logged in user adds one invitation to existing user" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @invitee1 = FactoryGirl.create(:user, email: "invitee1@example.com")
    @invitee2 = FactoryGirl.create(:user, email: "invitee2@example.com")
    sign_in @organizer
    @party = FactoryGirl.create(:party, organizer: @organizer)
    @invitation = FactoryGirl.create(:invitation, user: @invitee, party: @party)
    @invitation1 = FactoryGirl.create(:invitation, user: @invitee1, party: @party)
    @invitation2= FactoryGirl.create(:invitation, user: @invitee2, party: @party)
    @invitation3= FactoryGirl.create(:invitation, user: @organizer, party: @party)
    visit party_path(@party)
    click_link 'Draw Names'
    page.should have_content("Names Drawn Successfully.")
    expect(@invitation.receipient).not_to be_nil
    expect(@invitation.receipient).not_to eq(@invitation.user)
    expect(@invitation1.receipient).not_to be_nil
    expect(@invitation1.receipient).not_to eq(@invitation1.user)
    expect(@invitation2.receipient).not_to be_nil
    expect(@invitation2.receipient).not_to eq(@invitation2.user)
    expect(@invitation3.receipient).not_to be_nil
    expect(@invitation3.receipient).not_to eq(@invitation3.user)
  end
end
