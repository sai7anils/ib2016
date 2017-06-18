class User::BusinessIdeasController < ApplicationController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Identity
  include Frontend
  before_action :authenticate_user!
  layout 'idea'
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :load_close_ideas, only: [:new, :edit, :index]
  before_action :authenticate_entrepreneur!, only: [:new, :create]
  before_action :authenticate_creator!, only: [:edit, :update, :destroy]
  before_action :authenticate_investor_or_creator!, only: [:index, :show]
  before_action :authenticate_investor_verified_or_creator, only: [:show]

  def index
    @message = Message.new
    @identity = identity_form(current_user)
    if current_user.entrepreneur?
      @ideas = search_business_ideas(params, user: current_user)
    else
      @ideas = search_business_ideas(params)
    end
  end

  def show
    @message = Message.new
    @favorite = current_user.favorites.where(idea_id: @idea.id).present?
    @deal = current_user.deals.where(idea_id: @idea.id).present?
    @idea.update_attributes(views: @idea.views + 1)
    @idea_type = find_business_idea_type(@idea.business_idea.business_idea_type)
  end

  def new
    @idea = Idea.new
    @order = Order.new
    @idea.build_business_idea
    @idea.business_idea.build_market_analysis
    @idea.business_idea.build_team_cappabilitie
    @idea.business_idea.build_customer_analysis
    @idea.business_idea.build_investment_scale
    @idea.business_idea.build_business_potencial
    @idea.business_idea.build_exit_strategie
    @idea.business_idea.build_pitch_burn
    @idea.business_idea.pitch_burn.attachments.build
    @idea.business_idea.build_competitor
    @idea.business_idea.business_potencial.build_per_unit
    @idea.business_idea.business_potencial.build_per_hour
    @idea.business_idea.business_potencial.build_own_model
    @idea.business_idea.business_potencial.build_recurring
  end

  def create
    @value = current_user.profile_percentage
    if @value.first[:number] < 80
      data = {location: url_for(:controller => 'registrations', :action => 'edit')}
      render :json => data, :status => :ok
      #redirect_to edit_user_registration_path
      #render :js => "window.location = '/user/edit'"
    else
      @idea = prepare_idea_to_save
      # respond_to do |format|
      #   # if @idea.save
      #   #   format.html { redirect_to user_ideas_business_path, notice: 'Idea was successfully created.' }
      #   #   format.json { render :show, status: :created, location: @idea }
      #   # else
      #   #   format.html { render :new}
      #   #   format.json { render json: @idea.errors, status: :unprocessable_entity }
      #   # end
      if @idea.save
        data = {idea_id: @idea.id}
        render :json => data, :status => :ok
      else
        data = {:message => "Alert this!"}
        render :json => data, :status => :error
      end
      #end
    end
  end

  def edit
    @order = Order.new
  end

  def update
    @idea = prepare_idea_to_save
    respond_to do |format|
      if @idea.save
        format.html { redirect_to user_business_ideas_path, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :updated, location: @idea }
      else
        format.html { render :edit}
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def load_more
    if params[:action_page] == 'my_ideas' || current_user.entrepreneur?
      @ideas = search_business_ideas(params, user: current_user)
    else
      @ideas = search_business_ideas(params)
    end
    render layout: false
  end

  def destroy
    if @idea.destroy
      flash[:notice] = 'Idea was successfully destroyed.'
    end
    redirect_to user_business_ideas_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  def prepare_idea_to_save
    current_idea = Idea.by_name_status(idea_params[:title])
    @value = current_user.profile_percentage

    # check if user click validate and save mutiple times
    current_idea.first.destroy if current_idea.present?

    if @value.first[:number] < 80
      # redirect_to edit_user_registration_path
      render :js => "window.location = '/user/edit'"
    end
    @idea = current_user.ideas.new(idea_params.merge(idea_type: false, status: "pending"))
    @idea.business_idea = BusinessIdea.new(only_idea_business_params)
    @idea.business_idea.market_analysis = MarketAnalysis.new(only_idea_business_market_params)
    @idea.business_idea.customer_analysis = CustomerAnalysis.new(only_idea_business_custom_params)
    @idea.business_idea.investment_scale = InvestmentScale.new(only_idea_business_investment_params)
    @idea.business_idea.pitch_burn = PitchBurn.new(only_idea_business_pitch_params)
    @idea.business_idea.exit_strategie = ExitStrategie.new(only_idea_business_exit_params)
    @idea.business_idea.team_cappabilitie = TeamCappabilitie.new(team_cappabilitie_params)
    @idea.business_idea.business_potencial = BusinessPotencial.new(business_potencial_params)
    @idea.business_idea.competitor = Competitor.new(competitor_params)
    if per_unit_params[:sale] != '{}' || per_unit_params[:price] != '{}'
      per_unit = PerUnit.new(sale: ActiveSupport::JSON.decode(per_unit_params[:sale]), price: ActiveSupport::JSON.decode(per_unit_params[:price]))
      @idea.business_idea.business_potencial.per_unit = per_unit
    end
    if per_hour_params[:hour_rate] != '{}' || per_hour_params[:billable] != '{}'
      per_hour = PerHour.new(billable: ActiveSupport::JSON.decode(per_hour_params[:billable]), hour_rate: ActiveSupport::JSON.decode(per_hour_params[:hour_rate]))
      @idea.business_idea.business_potencial.per_hour = per_hour
    end
    if own_model_params[:revenue] != '{}'
      own_model = OwnModel.new(revenue: ActiveSupport::JSON.decode(own_model_params[:revenue]))
      @idea.business_idea.business_potencial.own_model = own_model
    end

    if recurring_params[:no_account] != '{}' || recurring_params[:charge] != '{}' || recurring_params[:churn_rate] != '{}'
      recurring = Recurring.new(no_account: ActiveSupport::JSON.decode(recurring_params[:no_account]), churn_rate: ActiveSupport::JSON.decode(recurring_params[:churn_rate]), charge: ActiveSupport::JSON.decode(recurring_params[:charge]))
      @idea.business_idea.business_potencial.recurring = recurring
    end
    # respond_to do |format|
    #   if @idea.save
    #     format.html { redirect_to business_user_ideas_path, notice: 'Idea was successfully created.' }
    #     format.json { render :show, status: :created, location: @idea }
    #   else
    #     format.html { render :business_new, template: 'user/ideas/business/new'}
    #     format.json { render json: @idea.errors, status: :unprocessable_entity }
    #   end
    # end
    @idea
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def idea_params
    params.require(:idea).permit(:category_id, :title, :description, :attachment, :idea_type)
  end

  def only_idea_business_params
    params.require(:idea).require(:business_idea_attributes).permit(:business_line, :tagline, :problem_statement, :solution, :idea_stage, :ip_patent, :motivation_vision,
      :year_exp, :startup_business, :business_model, :des_business_model, :idea_execution, :business_idea_type, :register_number)
  end

  def only_idea_business_pitch_params
    params.require(:idea).require(:business_idea_attributes).require(:pitch_burn_attributes).permit(:business_idea_id, :your_own, :your_video, :documents, :your_idea_legally, attachments_attributes: [:id , :file])
  end

  def only_idea_business_exit_params
    params.require(:idea).require(:business_idea_attributes).require(:exit_strategie_attributes).permit(:business_exit_strategy)
  end

  def only_idea_business_custom_params
    params.require(:idea).require(:business_idea_attributes).require(:customer_analysis_attributes).permit( :idea_solve, :big_customer, :about, :from_age, :to_age, :steps, :region => [])
  end

  def only_idea_business_investment_params
    params.require(:idea).require(:business_idea_attributes).require(:investment_scale_attributes).permit( :total_capital, :fund_already, :fund_like_to_invest, :fund_you_seeking, :offering_business, :use_fund)
  end

  def only_idea_business_market_params
    params.require(:idea).require(:business_idea_attributes).require(:market_analysis_attributes).permit( :is_new, :have_major, :market_size, :market_analyses_des, :market_trend, :market_channels)
  end

  def idea_business_params
    params.require(:idea).permit(:category_id, :title, :description, :attachment, :idea_type, business_idea_attributes: [:business_line, :tagline, :problem_statement, :solution, :idea_stage, :ip_patent, :motivation_vision,
      :year_exp, :startup_business, :business_model, :des_business_model, :idea_execution, :business_idea_type, :register_number])

  end

  def team_cappabilitie_params
    params.require(:idea).require(:business_idea_attributes).require(:team_cappabilitie_attributes).permit(:crucial_skills, :strength, :team_attributes,
      business_teams_attributes: [:id, :name, :role, :skills, :joined, :profile_image, :_destroy])
  end

  def business_potencial_params
    params.require(:idea).require(:business_idea_attributes).require(:business_potencial_attributes).permit(:projection_type, :term_number, :revenue_type, :per_hour, :recurring, :own_model)
  end

  def competitor_params
    params.require(:idea).require(:business_idea_attributes).require(:competitor_attributes).permit(:about, :image, competitor_teams_attributes: [:id, :name, :business_line, :country, :revenue, :website, :_destroy])
  end

  def per_unit_params
    params.require(:idea).require(:business_idea_attributes).require(:business_potencial_attributes).require(:per_unit_attributes).permit(:sale, :price)
  end

  def per_hour_params
    params.require(:idea).require(:business_idea_attributes).require(:business_potencial_attributes).require(:per_hour_attributes).permit(:hour_rate, :billable)
  end

  def own_model_params
    params.require(:idea).require(:business_idea_attributes).require(:business_potencial_attributes).require(:own_model_attributes).permit(:revenue)
  end

  def recurring_params
    params.require(:idea).require(:business_idea_attributes).require(:business_potencial_attributes).require(:recurring_attributes).permit(:churn_rate, :charge, :no_account)
  end

  def authenticate_entrepreneur!
    redirect_to user_ideas_path unless current_user.entrepreneur?
  end

  def authenticate_investor_or_creator!
    redirect_to user_ideas_path unless current_user.investor? || current_user.entrepreneur?
  end

  def authenticate_investor_verified_or_creator
    return if current_user.entrepreneur? && @idea.user == current_user
    return if current_user.investor? && current_user.investor.verified?
    redirect_to user_business_ideas_path
  end

  def authenticate_creator!
    unless current_user.entrepreneur? && @idea.user == current_user
      redirect_to user_business_ideas_path
    end
  end

  def search_business_ideas(params, user: nil)
    load_business_ideas(params, user)
  end

  def load_close_ideas
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(6) : nil
  end

end
