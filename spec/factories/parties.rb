FactoryGirl.define do
  factory :party do
    theme "MyString"
    date "2016-11-12"
    time "2016-11-12 15:06:32"
    rsvp_deadline "2016-11-12"
    association :organizer
  end
end
