require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

  it { should validate_presence_of :email }
  # it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password }
  it { should validate_length_of(:password).is_at_least(6) }

  it { should have_many :parties }
  it { should have_many :invitations }
end
