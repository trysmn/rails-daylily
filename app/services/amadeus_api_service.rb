require 'open_weather'

class AmadeusApiService
  def search_flights(origin_iata, event_iata, departure_date, return_date)
    key = "cwfGwLspYv9j5G6IpgJ1B0aUABEPFHcK"
    url = "https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=#{key}&origin=#{origin_iata}&destination=#{event_iata}&departure_date=#{departure_date}&return_date=#{return_date}&number_of_results=1"
    result = HTTParty.get(url)
    pars_res = result.parsed_response
  end

end
