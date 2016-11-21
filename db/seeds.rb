# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_girl_rails'

30.times do
  FactoryGirl.create(:user)
end

user = User.last
3.times do
  FactoryGirl.create(:party , organizer: user)
end

users = User.all
parties = Party.all

parties.each do |party|
  users.each do |user|
    @invitation = FactoryGirl.create(:invitation, user: user, party: party)
  end
end
