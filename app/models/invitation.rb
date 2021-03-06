class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :receipient, class_name: 'User'

  accepts_nested_attributes_for :user

  validates :party_id, :uniqueness => {:scope=>:user_id}

  validate :same_user_receipient

  before_create :generate_token

  def same_user_receipient
    if self.user_id == self.receipient_id
      errors.add(:receipient, "can't be the same as the user")
    end
  end

  def rsvp_status
    if rsvp.nil?
      return "Not Yet Replied"
    elsif rsvp
      return "Attending"
    else
      return "Not Attending"
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def send_invitation
    PartyMailer.invitation(self).deliver
  end

  def send_reminder
    PartyMailer.reminder(self).deliver
  end
end
