require 'amadeus_api_service'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :search, :show]
  before_action :set_event, only: [:show, :edit, :update, :delete]
  def home
    @city_airports = CityAirport.all
  end

  def index
    @events = Event.where("start_date <= :return AND end_date >= :departure", {departure: params[:search][:departure], return: params[:search][:return]})
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
      res = search.search_flights(params[:search][:origin_iata], iata, parsing_date(params[:search][:departure]), parsing_date(params[:search][:return]))
      @result_hash[city] = {flight_api_info: res, hotel_api_info: "coming"}
    end
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(flat_params)
    if event.save
      redirect_to event_path(event)
    else
      render :new
    end
  end

  def show
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

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :parsed_response, pictures: []) #Add more!!
  end

  def parsing_date(d)
    new_date = Date.strptime(d,'%d/%m/%Y')
    return new_date.strftime("%Y-%m-%d")
  end
end
