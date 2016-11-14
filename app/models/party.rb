class Party < ApplicationRecord
  belongs_to :organizer, class_name: 'User'
  has_one :location
  has_many :invitations

  accepts_nested_attributes_for :location
end
