require 'rails_helper'

RSpec.describe "wishlists/new", :type => :view do
  before(:each) do
    assign(:wishlist, Wishlist.new(
      :title => "MyString",
      :user => nil
    ))
  end

  it "renders new wishlist form" do
    render

    assert_select "form[action=?][method=?]", wishlists_path, "post" do

      assert_select "input#wishlist_title[name=?]", "wishlist[title]"

      assert_select "input#wishlist_user_id[name=?]", "wishlist[user_id]"
    end
  end
end
