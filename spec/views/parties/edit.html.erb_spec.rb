require 'rails_helper'

RSpec.describe "parties/edit", :type => :view do
  before(:each) do
    @party = assign(:party, Party.create!(
      :theme => "MyString",
      :address => "MyString",
      :user => nil
    ))
  end

  it "renders the edit party form" do
    render

    assert_select "form[action=?][method=?]", party_path(@party), "post" do

      assert_select "input#party_theme[name=?]", "party[theme]"

      assert_select "input#party_address[name=?]", "party[address]"

      assert_select "input#party_user_id[name=?]", "party[user_id]"
    end
  end
end
