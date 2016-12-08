require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "OrganizerSendsInvitations", :type => :feature do
  scenario "Logged in user sends email invitations to guests" do
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
    click_link 'Send Invitations'
    expect(ActionMailer::Base.deliveries.count).to eq(4)
  end
end
