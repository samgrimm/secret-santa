require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "UserCreatesWishlists", :type => :feature do
  scenario "logged in user creates a wishlist" do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, email: "user@example.com")
    sign_in @user
    visit root_url
    click_link 'Create a Wishlist'
    page.should have_content("New Wishlist")
    fill_in 'Title', with: "My Xmas Wish"
    click_button "Create Wishlist"
    page.should have_css( '.notice', 'You have a new wishlist')
    page.should have_content("Add Items to Your Wishlist")
    click_link "Add Items to Your Wishlist"
    fill_in 'Name', with: "Book about Ruby"
    fill_in 'Url', with: "http://example.com"
    click_button 'Add Item'
    page.should have_css( '.notice', 'You have added an item to your wishlist')
    page.should have_content( 'Add More Items')
    expect(@user.wishlists.count).to eq(1)
    expect(Wishlist.all.count).to eq(1)
    expect(Wishlist.last.user).to eq(@user)
    expect(Item.all.count).to eq(1)
  end
end
