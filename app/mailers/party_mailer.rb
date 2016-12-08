class PartyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.party_mailer.invitation.subject
  #
  def invitation(invite)
    @greeting = "Hi"
    @party = invite.party
    email = invite.user.email
    organizer_email = @party.organizer.email
    mail to: email, from: organizer_email , subject: "You have been invited!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.party_mailer.reminder.subject
  #
  def reminder(invite)
    @greeting = "Hi"
    @party = invite.party
    email = invite.user.email
    organizer_email = @party.organizer.email
    mail to: email, from: organizer_email , subject: "Please RSVP!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.party_mailer.secret_santa.subject
  #
  def secret_santa(invite)
    @greeting = "Hi"
    @party = invite.party
    @invite = invite
    email = invite.user.email
    organizer_email = @party.organizer.email
    mail to: email, from: organizer_email , subject:  "Shhhhh! Here is your secret santa!"
  end
end
