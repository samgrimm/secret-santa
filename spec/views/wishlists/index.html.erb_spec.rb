require 'rails_helper'

RSpec.describe "wishlists/index", :type => :view do
  before(:each) do
    assign(:wishlists, [
      Wishlist.create!(
        :title => "Title",
        :user => nil
      ),
      Wishlist.create!(
        :title => "Title",
        :user => nil
      )
    ])
  end

  it "renders a list of wishlists" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
