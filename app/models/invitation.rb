class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :party

  accepts_nested_attributes_for :user
end