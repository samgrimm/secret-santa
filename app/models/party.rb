class Party < ApplicationRecord
  belongs_to :organizer, class_name: 'User'
  has_one :location
  has_many :invitations
  validates :spending_limit, numericality: {greater_than_or_equal_to: 0.01}

  accepts_nested_attributes_for :location

  after_create :add_invitation_to_organizer


  def add_invitation_to_organizer
    self.invitations.create(user_id: self.organizer.id)
  end

  def draw_names
    pool = invitations
    random_pool = pool.shuffle
    second_to_last = pool.length - 2
    random_pool[pool.length-1].receipient = random_pool[0].user
    random_pool[pool.length-1].save
    for i in 0..second_to_last
      random_pool[i].receipient = random_pool[i+1].user
      random_pool[i].save
    end
  end
end
