class AmadeusApiService
  def search_flights(origin_iata, event_iata, departure_date, return_date)
    key = 'cwfGwLspYv9j5G6IpgJ1B0aUABEPFHcK' #Fransesco
    # key = 'vTE7KANhuQZ630Qm28BIJ3lSigFrGeus' #WJ
    url = "https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=#{key}&origin=#{origin_iata}&destination=#{event_iata}&departure_date=#{departure_date}&return_date=#{return_date}&number_of_results=1"
    result = HTTParty.get(url)
    pars_res = result.parsed_response
  end

  def search_hotels(event_iata, check_in_date, check_out_date)
    key = 'cwfGwLspYv9j5G6IpgJ1B0aUABEPFHcK' #Fransesco
    # key = 'vTE7KANhuQZ630Qm28BIJ3lSigFrGeus' #WJ
    # url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=#{key}&location=#{event_iata}&check_in=#{check_in_date}&check_out=#{check_out_date}&number_of_results=1"
    url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=vTE7KANhuQZ630Qm28BIJ3lSigFrGeus&location=BCN&check_in=2017-12-15&check_out=2017-12-16&radius=50&number_of_results=1"
    hotel_result = HTTParty.get(url)
    pars_hotel = hotel_result.parsed_response
  end

  def google_flights(origin_iata, event_iata, departure_date, return_date)
    response = HTTParty.post'https://www.googleapis.com/qpxExpress/v1/trips/search?key=AIzaSyCdvJJfgginvRdJ0rJuFSIUh6lQqjLHeDo',
               :body =>  {
                   request: {
                     passengers: {
                       adultCount: 1
                     },
                     slice: [
                       {
                         origin: origin_iata,
                         destination: event_iata,
                         date: departure_date
                       },
                       {
                         origin: event_iata,
                         destination: origin_iata,
                         date: return_date
                       }
                     ],
                     "solutions": "1"
                   }
                 }.to_json,
                  :headers => { 'Content-Type' => 'application/json' }
    return response
  end

  def hotwire_hotels
    key = 'xb3z5rkwbtxxu9nu6qxhd83y'
    # url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=#{key}&location=#{event_iata}&check_in=#{check_in_date}&check_out=#{check_out_date}&number_of_results=1"
    url = "http://api.hotwire.com/v1/search/hotel?apikey=xb3z5rkwbtxxu9nu6qxhd83y&dest=San%20Francisco,%20Ca.&rooms=1&adults=2&children=0&startdate=01/20/2018&enddate=01/23/2018"
    hotel_result = HTTParty.get(url)
    pars_hotel = hotel_result.parsed_response
  end

  def APItude_hotels
    key = 'd5yr7avqjz47q27fctaf7qmm'
    # url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=#{key}&location=#{event_iata}&check_in=#{check_in_date}&check_out=#{check_out_date}&number_of_results=1"
    url = "http://api.hotwire.com/v1/search/hotel?apikey=xb3z5rkwbtxxu9nu6qxhd83y&dest=San%20Francisco,%20Ca.&rooms=1&adults=2&children=0&startdate=01/20/2018&enddate=01/23/2018"
    hotel_result = HTTParty.get(url)
    pars_hotel = hotel_result.parsed_response
  end
end
