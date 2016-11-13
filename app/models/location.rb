class Location < ApplicationRecord
  belongs_to :party
  geocoded_by :address
  after_validation :geocode
end
