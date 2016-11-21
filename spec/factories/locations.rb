FactoryGirl.define do
  factory :location do
    address { Faker::Address.street_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    party nil
  end
end
