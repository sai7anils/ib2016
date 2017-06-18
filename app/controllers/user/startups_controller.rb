class User::StartupsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  layout :layout_by_action

  def index
    @users = search_startups(params)
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(5) : nil
  end

   def load_more
    @users = search_startups(params)
    render layout:false
  end

  def show
    @user = User.find(params[:id])
    @info = @user.startup
    ideas = current_user.ideas
    @ideas = Idea.by_closed.present? ? Idea.by_closed.sample(5) : nil
  end

  def fund_new
    # redirect_to user_ideas_path, notice: 'This feature will be added soon.' if current_user.startup?
  end

  def fund_show
  end

  def funds
  end

  private

  def search_startups(params)
    users = User.by_confirmed.joins(:startup)
    users = users.by_country(params[:country]) if params[:country].present?
    users = Startup.by_funding_type(users,params[:funding_type]) if params[:funding_type].present?
    users = Startup.by_business_line(users, params[:business_line]) if params[:business_line].present?
    users =  Kaminari.paginate_array(users).page(params[:page]).per(20)
    return users
  end

  def layout_by_action
   action_name == 'show' ? 'user' : 'idea'
  end
end
