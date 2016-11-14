require 'rails_helper'

RSpec.describe "parties/show", :type => :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @party = assign(:party, Party.create!(
      :theme => "Theme",
      :organizer => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Theme/)
  end
end
