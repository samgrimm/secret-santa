require 'rails_helper'

RSpec.describe Wishlist, :type => :model do
  it { should respond_to :title }
  it { should respond_to :user }

  it { should belong_to :user }
  # it { should have_many :items }
end
