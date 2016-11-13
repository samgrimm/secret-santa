require 'rails_helper'

RSpec.describe "parties/index", :type => :view do
  before(:each) do
    assign(:parties, [
      Party.create!(
        :theme => "Theme",
        :address => "Address",
        :user => nil
      ),
      Party.create!(
        :theme => "Theme",
        :address => "Address",
        :user => nil
      )
    ])
  end

  it "renders a list of parties" do
    render
    assert_select "tr>td", :text => "Theme".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
