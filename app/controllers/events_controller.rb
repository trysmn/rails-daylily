require 'amadeus_api_service'
require 'open-uri'
require 'nokogiri'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :search, :show]
  before_action :set_event, only: [:show, :edit, :update, :delete]
  def home
    @city_airports = CityAirport.all
  end

  # def index
  #   @events = Event.where("start_date <= :return AND end_date >= :departure", {departure: params[:search][:departure], return: params[:search][:return]})
  #   search = AmadeusApiService.new
  #   origin_city_obj = CityAirport.where("iata_code = :iata", {iata: params[:search][:origin_iata]}).first
  #   cities = []
  #   @events.each do |event|
  #     if event.city_airport != origin_city_obj
  #       cities << event.city_airport
  #     end
  #   end
  #   uniq_cities = cities.uniq
  #   @result_hash = {}
  #   uniq_cities.each do |event|
  #     city = event.city_name
  #     iata = event.iata_code
  #     res = search.search_flights(params[:search][:origin_iata], iata, parsing_date(params[:search][:departure]), parsing_date(params[:search][:return]))
  #     hotel_res = search.search_hotels(iata, parsing_date(params[:search][:departure]), parsing_date(params[:search][:return]))
  #     @result_hash[city] = {flight_api_info: res, hotel_api_info: hotel_res}
  #   end
  # end

  def index
    @events = Event.where("start_date <= :return AND end_date >= :departure", {departure: Date.strptime(params[:search][:departure],'%d/%m/%Y'), return: Date.strptime(params[:search][:return],'%d/%m/%Y')})
    search = AmadeusApiService.new
    origin_city_obj = CityAirport.where("iata_code = :iata", {iata: params[:search][:origin_iata]}).first
    cities = []
    @events.each do |event|
      if event.city_airport != origin_city_obj
        cities << event.city_airport
      end
    end
    uniq_cities = cities.uniq
    @result_hash = {}
    uniq_cities.each do |event|
      city = event.city_name
      iata = event.iata_code
      hotels_res = search.apitude_hotelbeds(iata, parsing_date(params[:search][:departure]), parsing_date(params[:search][:return]))
      flight_res = search.google_flights(params[:search][:origin_iata], iata, parsing_date(params[:search][:departure]), parsing_date(params[:search][:return]))
      @result_hash[city] = {flight_api_info: flight_res, hotel_api_info: hotels_res}
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.status = "pending"
    if @event.save
      @event.status = "approved"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    start_month = months[@event.start_date.mon - 1].downcase

    city_airport_id = @event.city_airport_id
    @city_name = CityAirport.find(city_airport_id).city_name

    # Scraping for Temperature:
    temp_url = "https://www.currentresults.com/Weather/Europe/Cities/temperature-#{start_month}.php"

    temp_html_file = open(temp_url).read
    temp_html_doc = Nokogiri::HTML(temp_html_file)

    temp_html_doc.search('.articletable.tablecol-3-left.revcolr tbody tr').each do |td|
      if td.text.split("\n")[3].split(",").include?(@city_name)
        @temps_array = []
        @temps_array << td.text.split("\n")[4]
        @temps_array << td.text.split("\n")[5]
      end
    end
    # Done

    # Scraping for Precipitation:
    precip_url = "https://www.currentresults.com/Weather/Europe/Cities/precipitation-#{start_month}.php"

    precip_html_file = open(precip_url).read
    precip_html_doc = Nokogiri::HTML(precip_html_file)

    precip_html_doc.search('.articletable.tablecol-2-left.revcolr tbody tr').each do |td|
      if td.text.split("\n")[2].split(",").include?(@city_name)
        @precips_array = []
        @precips_array << td.text.split("\n")[1]
        @precips_array << td.text.split("\n")[4]
      end
    end
    # Done

    # Scraping for Sunshine:
    sun_url = "https://www.currentresults.com/Weather/Europe/Cities/sunshine-average-#{start_month}.php"

    sun_html_file = open(sun_url).read
    sun_html_doc = Nokogiri::HTML(sun_html_file)

    sun_html_doc.search('.articletable.tablecol-1-left.revcolr tbody tr').each do |td|
      if td.text.split("\n")[1].split(",").include?(@city_name)
        @sun_array = []
        @sun_array << td.text.split("\n")[2]
      end
    end
    # Done

    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy!
    redirect_to events_path
  end

 # def weather_dest
 #    options = { units: "metric", APPID: "7717aa9c039af9baf7714dd430b8f3f6"}
 #    result = OpenWeather::Forecast.city("Milan", options)

 #    return result
 # end

 private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :parsed_response, :start_date, :end_date, :start_time, :end_time, :number_of_attendees, :average_temp, :entrance_fee, :website, :user_id, :address, :city_airport_id, photos: []) #Add more!!
  end

  def airport_params
    params.require(:event).permit(:address)
  end

  def parsing_date(d)
    new_date = Date.strptime(d,'%d/%m/%Y')
    return new_date.strftime("%Y-%m-%d")
  end
end
