require "rails_helper"

RSpec.describe PartyMailer, :type => :mailer do
  describe "invitation" do
    let(:user) { FactoryGirl.create(:user, email: "newuser@example.com") }
    let(:organizer) { FactoryGirl.create(:user, email: "organizer@example.com") }
    let(:party) { FactoryGirl.create(:party, organizer: organizer) }
    let(:invitation) { FactoryGirl.create(:invitation, user: user, party: party)}
    let(:mail) { PartyMailer.invitation(invitation) }

    it "renders the headers" do
      expect(mail.subject).to eq("You have been invited!")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["organizer@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("Hi, you have been invited to a party.")
      expect(mail.body.encoded).to include(party.theme)
    end
  end

  describe "reminder" do
    let(:user) { FactoryGirl.create(:user, email: "newuser@example.com") }
    let(:organizer) { FactoryGirl.create(:user, email: "organizer@example.com") }
    let(:party) { FactoryGirl.create(:party, organizer: organizer) }
    let(:invitation) { FactoryGirl.create(:invitation, user: user, party: party)}
    let(:mail) { PartyMailer.reminder(invitation) }

    it "renders the headers" do
      expect(mail.subject).to eq("Please RSVP!")
      expect(mail.to).to eq(["newuser@example.com"])
      expect(mail.from).to eq(["organizer@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(party.theme)
    end
  end

  describe "secret_santa" do
    let(:user) { FactoryGirl.create(:user, email: "newuser@example.com") }
    let(:organizer) { FactoryGirl.create(:user, email: "organizer@example.com") }
    let(:receipient) { FactoryGirl.create(:user, email: "receipient@example.com") }
    let(:party) { FactoryGirl.create(:party, organizer: organizer) }
    let(:invitation) { FactoryGirl.create(:invitation, user: user, party: party, receipient:receipient)}

    let(:mail) { PartyMailer.secret_santa(invitation) }


    it "renders the headers" do
      expect(mail.subject).to eq("Shhhhh! Here is your secret santa!")
      expect(mail.to).to eq(["newuser@example.com"])
      expect(mail.from).to eq(["organizer@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("Hi")
      expect(mail.body.encoded).to include(party.theme)
      expect(mail.body.encoded).to include(invitation.receipient.email)
    end
  end

end
