class User::EntrepreneursController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  layout :layout_by_action

  def index
    @users = search_ideas(params)
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(5) : nil
  end

  def load_more
    @users = search_ideas(params)
    render layout: false
  end

  def show
    @user = User.find(params[:id])
    @info = @user.entrepreneur
    ideas = current_user.ideas
    @ideas = Idea.by_closed.present? ? Idea.by_closed.sample(5) : nil
  end

  private

  def layout_by_action
    action_name == "show" ?  "user" : "idea"
  end

  def search_ideas(params)
    users = User.by_confirmed.joins(:entrepreneur)
    users = Entrepreneur.by_profession_type(users,params[:profession_type]) if params[:profession_type].present?
    users = users.by_country(params[:country]) if params[:country].present?
    users = Entrepreneur.by_skill(users, params[:skill_type]) if params[:skill_type].present?
    users = users.page(params[:page]).order('created_at desc').per(20)
    return users
  end

end
