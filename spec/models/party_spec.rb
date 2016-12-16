require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Party, :type => :model do
  it { should respond_to :organizer }
  it { should respond_to :location }
  it { should have_many :invitations }
  it { should belong_to :organizer }
  it { should have_one :location }
  it { should respond_to :spending_limit }

  it "should draw names without repeating or missing names" do
    DatabaseCleaner.clean
    30.times do
      FactoryGirl.create(:user)
    end
    user = User.first
    party = FactoryGirl.create(:party, organizer: user)
    users = User.all[1..-1]
    users.each do |user|
      @invitation = FactoryGirl.create(:invitation, user: user, party: party)
    end
    party.draw_names
    party.invitations.each do |invite|
      expect(invite.user.id).not_to eq(invite.receipient.id)
    end
  end

  it "should not have repeated guests" do
    DatabaseCleaner.clean
    3.times do
      FactoryGirl.create(:user)
    end
    user = User.first
    party = FactoryGirl.create(:party, organizer: user)
    users = User.all[1..-1]
    users.each do |user|
      @invitation = FactoryGirl.create(:invitation, user: user, party: party)
    end
    last_user = User.last
    last_invitation = party.invitations.build(user_id: last_user.id)
    expect(last_invitation.save).to eq(false)
    expect(Invitation.all.count).to eq(3)
  end
end
