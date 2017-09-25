require 'amadeus_api_service'

class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(origin_iata, unique_cities, departure, return_date, dep_date, ret_date)
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
    s_details = SearchDetail.new
    s_details.city_airport_id = CityAirport.find_by(iata_code: origin_iata).id
    s_details.departure_date = dep_date
    s_details.return_date = ret_date
    s_details.incoming_data = background_hash
    s_details.save
    s_details.id
  end
end
