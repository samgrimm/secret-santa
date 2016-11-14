require 'rails_helper'

RSpec.describe "parties/edit", :type => :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @party = assign(:party, Party.create!(
      :theme => "MyString",
      :organizer => @user
    ))
  end

  it "renders the edit party form" do
    render

    assert_select "form[action=?][method=?]", party_path(@party), "post" do

      assert_select "input#party_theme[name=?]", "party[theme]"

  
    end
  end
end
