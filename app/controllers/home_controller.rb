class HomeController < ApplicationController
  include ApplicationHelper
  before_filter :load_events

  def index
    @ideas           = Category.latest_ideas
    @deals_count     = Deal.count
    @investors_count = User.by_confirmed.investor.count
    @startups_count  = User.by_confirmed.startup.count
    @ideas_count     = Idea.count
  end

  def loadmoreentrepreneur
    pageno = params[:pageno].to_i
    @users = User.entrepreneur.order('created_at desc').page(params[:pageno]).per(8)
    render 'home/_loadmoreentrepreneur', layout: false
  end

  def loadmoreinvestor
    pageno = params[:pageno].to_i
    @users = User.investor.order('created_at desc').page(params[:pageno]).per(8)
    render 'home/_loadmoreinvestor', layout: false
  end

  def loadmorestartup
    pageno = params[:pageno].to_i
    @users = User.startup.order('created_at desc').page(params[:pageno]).per(8)
    render 'home/_loadmorestartup', layout: false
  end

  def loadmoreevents
    @events = search_events(params)
    render layout: false
  end

  private

  def load_events
    @events = search_events(params)
  end

  def search_events(params)
    events = Event.all.includes(:user)
    events = events.by_keyword(params[:keyword]) if params[:keyword].present?
    events = events.by_country(params[:country])if params[:country].present?
    events = events.by_date(validate_date(params[:date])) if params[:date].present?
    events = events.page(params[:page]).order('event_from desc').per(5)
  end
end
