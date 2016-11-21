require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "GuestEmailRsvps", :type => :feature do
  scenario "only the guest can see the invitation page" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "organizer@example.com")
    @guest = FactoryGirl.create(:user, email: "guest@example.com")
    @party = FactoryGirl.create(:party, organizer: @organizer, theme: "My invite test")
    @invitation = FactoryGirl.create(:invitation, user: @guest, party: @party)
    path = 
    visit('')
  end
end
