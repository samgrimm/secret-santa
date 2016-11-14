require 'rails_helper'

RSpec.describe Party, :type => :model do
  it { should respond_to :organizer }
  it { should respond_to :location }
  it { should have_many :invitations }
  it { should belong_to :organizer }
  it { should have_one :location }
end
