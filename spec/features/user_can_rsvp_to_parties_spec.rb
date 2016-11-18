require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "UserCanRsvpToParties", :type => :feature do
  scenario "Logged in guest can rsvp yes to party" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @party = FactoryGirl.create(:party, organizer: @organizer)
    @invitation = FactoryGirl.create(:invitation, user: @invitee, party: @party)
    sign_in @invitee
    visit party_invitation_path(@party, @invitation)
    page.should have_text('Will Attend')
    page.should have_text('Will Not Attend')
    page.should_not have_link('Edit')
    click_link('Will Attend')
    page.should have_content('Thank you for confirming.')
    page.should have_content('Create a wishlist')
  end

  scenario "Logged in guest can rsvp no to party" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    @party = FactoryGirl.create(:party, organizer: @organizer)
    @invitation = FactoryGirl.create(:invitation, user: @invitee, party: @party)
    sign_in @invitee
    visit party_invitation_path(@party, @invitation)
    page.should have_text('Will Attend')
    page.should have_text('Will Not Attend')
    page.should_not have_link('Edit')
    click_link('Will Not Attend')
    page.should have_content("Sorry you can't make it.")
  end

  scenario "Guest with confirmation token can rsvp to party" do
    DatabaseCleaner.clean

  end
end
