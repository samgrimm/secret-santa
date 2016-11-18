require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "UserCanRsvpToParties", :type => :feature do
  scenario "Guest can rsvp yes to party" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @party = FactoryGirl.create(:party, organizer: @organizer)
    @invitation = FactoryGirl.create(:invitation, user: @invitee, party: @party)
    visit party_invitation_path(@party, @invitation)
    save_and_open_page
    page.should have_link('RSVP')
    page.should_not have_link('Edit')
  end
end
