require 'amadeus_api_service'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search, :show]
  before_action :set_event, only: [:show, :edit, :update, :delete]
  def home
  end

  def index
    @events = Event.where("start_date <= :return AND end_date >= :departure", {departure: params[:search][:departure], return: params[:search][:return]})
    search = AmadeusApiService.new
    @array = []
    @events.each do |event|
      flight_res = {}
      city = event.city_airport.city_name
      iata = event.city_airport.iata_code
      res = search.search_flights(params[:search][:origin_city], params[:search][:departure], params[:search][:return])
      @array << flight_res = {city => res}
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
end
