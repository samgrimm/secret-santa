require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "InvitationAuthorizations", :type => :feature do
  scenario "only the guest can see the invitation page" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "organizer@example.com")
    @guest = FactoryGirl.create(:user, email: "guest@example.com")
    sign_in @guest
    @party = FactoryGirl.create(:party, organizer: @organizer, theme: "My invite test")
    @invitation = FactoryGirl.create(:invitation, user: @guest, party: @party)
    visit party_invitation_path(@party, @invitation)
    page.should have_content("My invite test")
    page.should have_link("Will Attend")
    page.should have_link("Will Not Attend")
  end

  scenario "only the guest can see the invitation page" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "organizer@example.com")
    @guest = FactoryGirl.create(:user, email: "guest@example.com")
    sign_in @organizer
    @party = FactoryGirl.create(:party, organizer: @organizer, theme: "My invite test")
    @invitation = FactoryGirl.create(:invitation, user: @guest, party: @party)
    visit party_invitation_path(@party, @invitation)
    page.should have_content("You may not access this page")
    page.should_not have_link("Will Attend")
    page.should_not have_link("Will Not Attend")
  end
end
