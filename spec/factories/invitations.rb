FactoryGirl.define do
  factory :invitation do
    association :user
    association :party
    rsvp false
  end
end
