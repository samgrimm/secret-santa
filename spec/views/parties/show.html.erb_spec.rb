require 'rails_helper'

RSpec.describe "parties/show", :type => :view do
  before(:each) do
    @party = assign(:party, Party.create!(
      :theme => "Theme",
      :address => "Address",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Theme/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(//)
  end
end
