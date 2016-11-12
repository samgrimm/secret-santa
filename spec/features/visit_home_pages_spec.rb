require 'rails_helper'
require 'spec_helper'

feature "VisitHomePages" do
  scenario 'user sees navbar on the page' do
    visit root_path
    expect(page).to have_css '.navbar', 'GiftExchange'
    expect(page).to have_text  'Login'
    expect(page).to have_text  'About'
    expect(page).to have_text  'Blog'
    expect(page).to have_text  'Start Party'
  end
end
