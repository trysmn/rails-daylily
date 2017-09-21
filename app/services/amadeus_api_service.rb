require 'open_weather'

class AmadeusApiService

  def search_flights(origin, outbound_date, inbound_date)
    result = HTTParty.get("https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=vTE7KANhuQZ630Qm28BIJ3lSigFrGeus&origin=BOS&destination=LON&departure_date=2017-12-25&number_of_results=1")
    pars_res = result.parsed_response
  end

end
