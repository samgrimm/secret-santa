require 'rails_helper'

RSpec.describe "parties/new", :type => :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:party, Party.new(
      :theme => "MyString",
      :organizer => @user
    ))
  end

  it "renders new party form" do
    render

    assert_select "form[action=?][method=?]", parties_path, "post" do

      assert_select "input#party_theme[name=?]", "party[theme]"
    end
  end
end
