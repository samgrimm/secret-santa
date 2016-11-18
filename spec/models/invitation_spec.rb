require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Invitation, :type => :model do
  it { should respond_to :party }
  it { should respond_to :user }
  it { should respond_to :rsvp_status }
  it { should belong_to :party }
  it { should belong_to :user }
  it { should have_one :receipient }
  it { should respond_to :receipient_id }

  it "should validate uniqueness of party on the user scope" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    party = FactoryGirl.create(:party, organizer: user)
    invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    invitation = party.invitations.build(user_id: invitee.id)
    invitation.save
    dup_invitation = party.invitations.build(user_id: invitee.id)
    expect(dup_invitation.save).to eq(false)
  end

  it "should validate that user and receipient are not the same" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    party = FactoryGirl.create(:party, organizer: user)
    invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    invitation = party.invitations.build(user_id: invitee.id)
    invitation.save
    invitation.receipient_id = invitee.id
    expect(invitation.save).to eq(false)
  end

  it "should show the correct rsvp status using the rsvp_status method" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    party = FactoryGirl.create(:party, organizer: user)
    invitee = FactoryGirl.create(:user, email: "invitee@example.com")
    invitation = party.invitations.build(user_id: invitee.id)
    invitation.save
    expect(invitation.rsvp_status).to eq("Not Yet Replied")

    invitation.update_attributes(rsvp: true)
    expect(invitation.rsvp_status).to eq("Attending")

    invitation.update_attributes(rsvp: false)
    expect(invitation.rsvp_status).to eq("Not Attending")
  end
end
