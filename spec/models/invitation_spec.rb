require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  it { should respond_to :party }
  it { should respond_to :user }
  it { should belong_to :party }
  it { should belong_to :user }
end
