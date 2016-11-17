class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :party
  has_one :receipient, class_name: 'User'

  accepts_nested_attributes_for :user

  validates :party_id, :uniqueness => {:scope=>:user_id}

  validate :same_user_receipient

  def same_user_receipient
    if self.user_id == self.receipient_id
      errors.add(:receipient, "can't be the same as the user")
    end
  end
end
