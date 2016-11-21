require 'rails_helper'

RSpec.describe "Invitations", :type => :request do
  describe "PUT parties/:party_id/invitations/:id/:token" do
    it "should rsvp to the party" do
      user = FactoryGirl.create(:user)
      party = FactoryGirl.create(:party, organizer: user)
      guest = FactoryGirl.create(:user, email: "guest@example.com")
      invitation = FactoryGirl.create(:invitation, party: party, user: guest)
      put_path = "/parties/#{party.id}/invitations/#{invitation.token}"
      rsvp = {
        :invitation => { :rsvp => true }
      }
      put put_path , params: rsvp
    end
  end
end
