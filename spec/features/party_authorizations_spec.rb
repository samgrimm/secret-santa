require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation


feature "PartyAuthorizations", :type => :feature do
  scenario "only party organizer can see the party page" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "organizer@example.com")
    sign_in @organizer
    @party = FactoryGirl.create(:party, organizer: @organizer)
    visit party_path(@party)
    page.should have_link("Draw Names")
    page.should have_link("Edit")
  end
  scenario "user who is not the organizer cannot see the party page" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "organizer@example.com")
    @not_organizer = FactoryGirl.create(:user, email: "not_organizer@example.com")
    sign_in @not_organizer
    @party = FactoryGirl.create(:party, organizer: @organizer)
    visit party_path(@party)
    page.should have_content("You are not the party organizer")
    page.should_not have_link("Draw Names")
    page.should_not have_link("Edit")
  end
  scenario "organizer can see only parties he organized and parties he is invited on index" do
    DatabaseCleaner.clean
    @organizer = FactoryGirl.create(:user, email: "organizer@example.com")
    @other_organizer = FactoryGirl.create(:user, email: "other_organizer@example.com")
    sign_in @organizer
    @party = FactoryGirl.create(:party, organizer: @organizer, theme: "It's My Party")
    @party2 = FactoryGirl.create(:party, organizer: @other_organizer ,theme: "And I will Cry if I want to")
    @party3 = FactoryGirl.create(:party, organizer: @other_organizer, theme: "Red Red Wine")
    @invitation = FactoryGirl.create(:invitation, user: @organizer, party: @party2)
    visit parties_path
    page.should have_content("It's My Party")
    page.should have_content("Parties I'm Organizing")
    page.should have_content("My Invitations")
    page.should have_content("And I will Cry if I want to")
    page.should_not have_content("Red Red Wine")
  end

end
