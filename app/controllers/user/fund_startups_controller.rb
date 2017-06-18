class User::FundStartupsController < ApplicationController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Identity
  include Frontend
  before_action :authenticate_user!
  layout 'idea'
  before_action :set_fund_startup, only: [:show, :edit, :update, :destroy]
  # before_action :load_close_ideas, only: [:new, :edit, :index]
  before_action :authenticate_startup!, only: [:new, :create]
  # before_action :authenticate_creator!, only: [:edit, :update, :destroy]
  # before_action :authenticate_investor_or_creator!, only: [:index, :show]
  # before_action :authenticate_investor_verified_or_creator, only: [:show]
  skip_before_action :verify_authenticity_token


  def index
    @funds = FundStartup.all
    # @message = Message.new
    # if current_user.startup?
    #   @ideas = search_business_ideas(params, user: current_user)
    # else
    #   @ideas = search_business_ideas(params)
    # end
  end

  def show
    # @message = Message.new
    # @favorite = current_user.favorites.where(idea_id: @idea.id).present?
    # @deal = current_user.deals.where(idea_id: @idea.id).present?
    # @idea_type = find_business_idea_type(@idea.business_idea.business_idea_type)
    @fund_startup.count_view
  end

  def new
    redirect_to user_ideas_path, notice: 'This feature will be added soon.'
    @fund_startup = current_user.startup.fund_startups.new
    @fund_startup.build_product_service
    @fund_startup.build_business_potential
    @fund_startup.business_potential.build_fund_business_model
    @fund_startup.business_potential.build_fund_market_trend
    @fund_startup.business_potential.build_customer_problem
    @fund_startup.business_potential.build_competitive_protection
    @fund_startup.business_potential.competitive_protection.competitor_teams.build
    @fund_startup.build_financial
    @fund_startup.build_legal_advisor
    @fund_startup.build_valuation
    @fund_startup.build_fund_pitch_burn
    @fund_startup.fund_pitch_burn.attachments.build
  end

  def create
    @fund_startup = prepare_fund_startup_to_save
    if @fund_startup.save
      data = {fund_startup_id: @fund_startup.id}
      redirect_to user_fund_startups_path, notice: 'Startup Fund was successfully created.'
      # format.json { render :show, status: :created, location: @idea }
    else
      data = {:message => "Alert this!"}
      render :json => data, :status => :error
    end
  end

  def edit; end

  def update
    @fund_startup = prepare_fund_startup_to_save
    respond_to do |format|
      if @fund_startup.save
        format.html { redirect_to user_fund_startups_path, notice: 'fund_startup was successfully updated.' }
        format.json { render :show, status: :updated, location: @fund_startup }
      else
        format.html { render :edit}
        format.json { render json: @fund_startup.errors, status: :unprocessable_entity }
      end
    end
  end

  # def load_more
  #   if params[:action_page] == 'my_ideas' || current_user.entrepreneur?
  #     @ideas = search_business_ideas(params, user: current_user)
  #   else
  #     @ideas = search_business_ideas(params)
  #   end
  #   render layout: false
  # end

  def destroy
    if @fund_startup.destroy
      flash[:notice] = 'Fund Startup was successfully destroyed.'
    end
    redirect_to user_fund_startups_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fund_startup
    @fund_startup = FundStartup.find(params[:id])
  end

  def prepare_fund_startup_to_save
    @fund_startup = current_user.startup.fund_startups.new
    @fund_startup.build_product_service
    @fund_startup.build_business_potential
    @fund_startup.business_potential.build_fund_business_model
    @fund_startup.business_potential.build_fund_market_trend
    @fund_startup.business_potential.build_customer_problem
    @fund_startup.business_potential.build_competitive_protection
    @fund_startup.business_potential.competitive_protection.competitor_teams.build
    @fund_startup.build_financial
    @fund_startup.build_legal_advisor
    @fund_startup.build_valuation
    @fund_startup.build_fund_pitch_burn
    @fund_startup.fund_pitch_burn.attachments.build


    @fund_startup.product_service = ProductService.new(product_service_params)
    # @fund_startup.business_potential = BusinessPotential.new(business_potential_params)
    @fund_startup.business_potential.fund_business_model = FundBusinessModel.new(fund_business_model_params)
    @fund_startup.business_potential.fund_market_trend = FundMarketTrend.new(fund_market_trend_params)
    @fund_startup.business_potential.customer_problem = CustomerProblem.new(customer_problem_params)
    @fund_startup.business_potential.competitive_protection = CompetitiveProtection.new(competitive_protection_params)
    @fund_startup.financial = Financial.new(financial_params)
    @fund_startup.legal_advisor = LegalAdvisor.new(legal_advisor_params)
    @fund_startup.valuation = Valuation.new(valuation_params)
    @fund_startup.fund_pitch_burn = FundPitchBurn.new(fund_pitch_burn_params)
    @fund_startup
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def fund_startup_params
  #   params.require(:fund_startup).permit(:category_id, :title, :description, :attachment, :idea_type)
  # end

  def product_service_params
    params.require(:fund_startup).require(:product_service_attributes).permit(:fund_startup_id, :about, :primary_business, :name, :type, :subtype, :description, :product_competitive)
  end

  def business_potential_params
    params.require(:fund_startup).require(:business_potential_attributes).permit(:fund_startup_id)
  end

  def fund_business_model_params
    params.require(:fund_startup).require(:business_potential_attributes).require(:fund_business_model_attributes).permit(:business_potential_id, :type, :subtype, :startup_process, :mvp)
  end

  def customer_problem_params
    params.require(:fund_startup).require(:business_potential_attributes).require(:customer_problem_attributes).permit(:business_potential_id, :explain, :from_age, :to_age, :potential_competitor, :checkout, :region => [])
  end

  def competitive_protection_params
    params.require(:fund_startup).require(:business_potential_attributes).require(:competitive_protection_attributes).permit(:business_potential_id, :strategy, competitor_teams_attributes: [:id, :name, :business_line, :country, :revenue, :website, :_destroy])
  end

  def fund_market_trend_params
    params.require(:fund_startup).require(:business_potential_attributes).require(:fund_market_trend_attributes).permit(:business_potential_id, :market_growing, :startup_process, :market_size, :describe, :approx)
  end

  def fund_pitch_burn_params
    params.require(:fund_startup).require(:fund_pitch_burn_attributes).permit(:business_potential_id, :fund_startup_id, :pitch, :video, :document, :prefer_exit, :validation, attachments_attributes: [:id , :file])
  end

  def financial_params
    params.require(:fund_startup).require(:financial_attributes).permit(:fund_startup_id, :revenue, :often, :previous_revenue, :current_revenue, :previous_netprofit, :crowd_funding, :put_money, {balance_sheets: []}, {cash_flows: []}, :equity_debt)
  end

  def legal_advisor_params
    params.require(:fund_startup).require(:legal_advisor_attributes).permit(:fund_startup_id, :professional_advisor, :board_advisor, :member, :professional_advice, :board_manager)
  end

  def valuation_params
    params.require(:fund_startup).require(:valuation_attributes).permit( :fund_startup_id, :currently_outstanding, :total_fund, :seeking, :pre_money, :business_stake, :use_fund)
  end

  def authenticate_startup!
    redirect_to user_ideas_path unless current_user.startup?
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

  # def search_business_ideas(params, user: nil)
  #   load_business_ideas(params, user)
  # end

  # def load_close_ideas
  #   @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(6) : nil
  # end

end
