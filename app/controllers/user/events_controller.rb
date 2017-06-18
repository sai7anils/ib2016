class User::EventsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  layout 'idea'
  before_action :load_popular_events, only: [:index, :new, :show, :my_events, :edit, :create, :update]
  before_action :set_event, only: [:show, :edit, :update]

  def index
    if params[:page]
      @page = params[:page].to_i + 1
      @load_popular_events = Event.order("views DESC").limit(@page*2)
    end
    @events = search_events(params)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @event.update_attributes(views: @event.views + 1)
  end

  def load_more_events
    if params[:action_page] == 'index'
      @events = search_events(params)
    elsif params[:action_page] == 'my_events'
      @events = search_events(params, user: current_user)
    end
    render layout: false
  end

  def my_events
    @events = search_events(params, user: current_user)
    render :index
  end

  def edit; end

  def update
    if @event.my_event?(current_user)
      respond_to do |format|
        @event.update_attributes(event_params)
        if @event.save
          flash[:update_event_success] = true
          format.html { redirect_to action: :edit }
          format.json { render :edit, status: :updated, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to user_my_events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :entry_type, :paid_entry_cost_min, :event_category, :website, :event_image, :partner_logo, :description, :address_line_1, :address_line_2, :country, :city, :region, :zipcode, :event_partner, :event_from, :event_to, :timezone, :event_time, partners_attributes: [:id, :name, :logo, :_destroy])
  end

  def search_events(params, user: nil)
    events = Event.all
    events = User.find(user).events unless user.nil?
    events = events.by_keyword(params[:keyword]) if params[:keyword].present?
    events = events.by_country(params[:country])if params[:country].present?
    events = events.by_date(validate_date(params[:date])) if params[:date].present?
    events = events.page(params[:page]).order('event_from desc').per(10)
  end

  def load_popular_events
    @load_popular_events = Event.order("views DESC").limit(2)
  end

  def set_event
    @event = Event.find(params[:id]) rescue nil
    if !@event
      redirect_to action: :index
    end
  end

end
