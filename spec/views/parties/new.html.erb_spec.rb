require 'rails_helper'

RSpec.describe "parties/new", :type => :view do
  before(:each) do
    assign(:party, Party.new(
      :theme => "MyString",
      :address => "MyString",
      :user => nil
    ))
  end

  it "renders new party form" do
    render

    assert_select "form[action=?][method=?]", parties_path, "post" do

      assert_select "input#party_theme[name=?]", "party[theme]"

      assert_select "input#party_address[name=?]", "party[address]"

      assert_select "input#party_user_id[name=?]", "party[user_id]"
    end
  end
end
