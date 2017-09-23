class CityAirport < ApplicationRecord
  has_many :events
  has_many :search_details
end
