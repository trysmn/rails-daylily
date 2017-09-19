class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search, :show]
  before_action :set_event, only: [:show, :edit, :update, :delete]
  def index
    @events = Event.all
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
    params.require(:event).permit(:title, :description, pictures: []) #Add more!!
  end
end