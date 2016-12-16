FactoryGirl.define do
  factory :party do
    theme Faker::Book.title
    date "2016-11-12"
    time "2016-11-12 15:06:32"
    rsvp_deadline "2016-11-12"
    spending_limit 50.00
    association :organizer
  end
end
