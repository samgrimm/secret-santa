require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "OrganizerSendsReminders", :type => :feature do
  scenario "Logged in user sends email reminders to guests" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "newuser@example.com")
    @invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    sign_in @organizer
    @party = FactoryGirl.create(:party, organizer: @organizer)
    @invitation = FactoryGirl.create(:invitation, user: @invitee, party: @party)
    visit party_path(@party)
    click_link 'Send Reminder'
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
