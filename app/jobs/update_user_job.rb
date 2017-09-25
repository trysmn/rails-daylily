require 'amadeus_api_service'

class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(origin_iata, unique_cities, departure, return_date)
    # TODO: perform a time consuming task like Clearbit's Enrinchment API.
    search = AmadeusApiService.new
    background_hash = {}
    unique_cities.each do |event|
      city = event.city_name
      iata = event.iata_code
      hotels_res = search.apitude_hotelbeds(iata, departure, return_date)
      flight_res = search.google_flights(origin_iata, iata, departure, return_date)
      background_hash[city] = {flight_api_info: flight_res, hotel_api_info: hotels_res}
    end
    # return background_hash
  end
end
