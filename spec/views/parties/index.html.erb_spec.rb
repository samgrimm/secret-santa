require 'rails_helper'

RSpec.describe "parties/index", :type => :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:parties, [
      Party.create!(
        :theme => "Theme",
        :organizer => @user
      ),
      Party.create!(
        :theme => "Theme",
        :organizer => @user
      )
    ])
  end

  it "renders a list of parties" do
    render
    assert_select "tr>td", :text => "Theme".to_s, :count => 2
  end
end
