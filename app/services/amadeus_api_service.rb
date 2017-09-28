# new push due to heroku
require 'open_weather'

class AmadeusApiService
  def google_flights(origin_iata, event_iata, departure_date, return_date)
    api_key = ENV['GOOGLE_FLIGHTS_KEY']
    response = HTTParty.post"https://www.googleapis.com/qpxExpress/v1/trips/search?key=#{api_key}",
               :body =>  {
                   request: {
                     passengers: {
                       adultCount: 1
                     },
                     slice: [
                       {
                         origin: origin_iata,
                         destination: event_iata,
                         date: departure_date,
                         maxStops: 0
                       },
                       {
                         origin: event_iata,
                         destination: origin_iata,
                         date: return_date,
                         maxStops: 0
                       }
                     ],
                     saleCountry: "NL",
                     ticketingCountry: "NL",
                     solutions: "1"
                   }
                 }.to_json,
                  :headers => { 'Content-Type' => 'application/json' }

    if response['trips']['data'].size < 2
      return {"error"=>{"error"=>"No flights available", "qpx_error"=>response}}
    else
      return response
    end
  end


  def apitude_hotelbeds(event_iata, check_in_date, check_out_date)
    start_date = Date.parse(check_in_date)
    end_date = Date.parse(check_out_date)
    total = end_date - start_date
    total_s = total.to_i

    response = HTTParty.post'http://testapi.hotelbeds.com/hotel-api/1.0/hotels',
    :headers =>{
      "Api-Key": ENV['HOTELBEDS_API_KEY'],
      "Content-Type": "application/json",
      "Accept": "application/json"
    },
    :body =>{
      "stay": {
        "checkIn": check_in_date,
        "checkOut": check_out_date,
      },
      "occupancies": [
        {
          "rooms": 1,
          "adults": 2,
          "children": 0,
          "paxes": [
            {
              "type": "AD",
              "age": "30"
            }
          ]
        }
      ],
      "filter": {
        "maxHotels": 10,
        "maxRooms": 1,
        "maxRatesPerRoom": 1,
        "minCategory": 1,
        "maxCategory": 5,
        "paymentType": "BOTH",
        "maxRate": (total_s * 150).to_s
      },
      "destination": {
        "code": event_iata
      }
    }.to_json
    if response.parsed_response.keys.any? {|k| k.include? "error"}
      {"error" => response.parsed_response['error']}
    else
      if response.parsed_response['hotels']['total'] == 0
        {"error" => "No hotels available"}
      else
        response.parsed_response["hotels"]["hotels"].sort_by {|k| k["minRate"].to_i}.first
      end
    end
  end

  def geolocation_hotelbeds(lat_event, lon_event, check_in_date, check_out_date)
    start_date = Date.parse(check_in_date)
    end_date = Date.parse(check_out_date)
    total = end_date - start_date
    total_s = total.to_i

    response = HTTParty.post'http://testapi.hotelbeds.com/hotel-api/1.0/hotels',
    :headers =>{
      "Api-Key": ENV['HOTELBEDS_API_KEY'],
      "Content-Type": "application/json",
      "Accept": "application/json"
    },
    :body =>{
      "stay": {
        "checkIn": check_in_date,
        "checkOut": check_out_date,
      },
      "occupancies": [
        {
          "rooms": 1,
          "adults": 2,
          "children": 0,
          "paxes": [
            {
              "type": "AD",
              "age": "30"
            }
          ]
        }
      ],
      "filter": {
        "maxHotels": 10,
        "maxRooms": 1,
        "maxRatesPerRoom": 1,
        "minCategory": 1,
        "maxCategory": 5,
        "paymentType": "BOTH",
        "maxRate": (total_s * 150).to_s
      },
      "geolocation": {
      "latitude": lat_event,
      "longitude": lon_event,
      "radius": 10,
      "unit": "km"
      }
    }.to_json
    if response.parsed_response.keys.any? {|k| k.include? "error"}
      {"error" => response.parsed_response['error']}
    else
      if response.parsed_response['hotels']['total'] == 0
        {"error" => "No hotels available"}
      else
        response.parsed_response["hotels"]["hotels"].sort_by {|k| k["minRate"].to_i}.first
      end
    end
  end

  # def search_flights(origin_iata, event_iata, departure_date, return_date)
  #   key = ENV['AMADEUS_FLIGHT_API_FRANSECO'] #Fransesco
  #   url = "https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=#{key}&origin=#{origin_iata}&destination=#{event_iata}&departure_date=#{departure_date}&return_date=#{return_date}&number_of_results=1"
  #   result = HTTParty.get(url)
  #   pars_res = result.parsed_response
  # end

  # def search_hotels(event_iata, check_in_date, check_out_date)
  #   key = ENV['AMADEUS_FLIGHT_API_FRANSECO'] #Fransesco
  #   # url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=#{key}&location=#{event_iata}&check_in=#{check_in_date}&check_out=#{check_out_date}&number_of_results=1"
  #   url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=vTE7KANhuQZ630Qm28BIJ3lSigFrGeus&location=BCN&check_in=2017-12-15&check_out=2017-12-16&radius=50&number_of_results=1"
  #   hotel_result = HTTParty.get(url)
  #   pars_hotel = hotel_result.parsed_response
  # end

  # def hotwire_hotels
  #   key = ENV['HOTWIRE_HOTEL_API_KEY']
  #   # url = "https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=#{key}&location=#{event_iata}&check_in=#{check_in_date}&check_out=#{check_out_date}&number_of_results=1"
  #   url = "http://api.hotwire.com/v1/search/hotel?apikey=xb3z5rkwbtxxu9nu6qxhd83y&dest=San%20Francisco,%20Ca.&rooms=1&adults=2&children=0&startdate=01/20/2018&enddate=01/23/2018"
  #   hotel_result = HTTParty.get(url)
  #   pars_hotel = hotel_result.parsed_response
  # end

  # def allmyles_hotels
  #   response = HTTParty.post'https://dev.allmyles.com/v2.0/hotels',
  #     :values => {
  #       'cityCode': "LON",
  #       occupancy: 1,
  #       arrivalDate: "2014-09-29",
  #       leaveDate: "2014-09-30"
  #     }.to_json,
  #     :headers => {
  #       :'X-Auth-Token' => ENV['ALLMYLES_HOTEL_API_KEY'],
  #       :Cookie => '122432-sa0-2312-439',
  #       :content_type => 'application/json'
  #     }
  #   return response
  # end
end
