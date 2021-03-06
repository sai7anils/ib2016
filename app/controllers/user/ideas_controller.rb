class User::IdeasController < ApplicationController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Identity
  include Frontend
  before_action :authenticate_user!
  layout 'idea'

  before_action :set_idea, only: [:show, :edit, :update, :destroy, :business_show]
  before_action :load_close_ideas, only: [:index, :show, :new, :edit, :create, :update, :my_ideas, :business_new, :business_create, :business_index]
  before_action :authenticate_entrepreneur!, only: [:business_new, :business_create]
  before_action :authenticate_investor!, only: [:business_index, :business_show]
  before_action :authenticate_investor_verified, only: [:business_show]
  skip_before_action :verify_authenticity_token

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = search_ideas(params)
  end

  def load_more
    if params[:action_page] == 'my_ideas'
      @ideas = search_ideas(params, user: current_user)
    else
      @ideas = search_ideas(params)
    end
    render layout: false
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea.update_attributes(views: @idea.views + 1)
    @ideas = @idea.user.ideas.where.not(id: @idea.id).sample(4)
    @most_views = Idea.order("views DESC").limit(4)
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.ideas.build(idea_params)
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(5) : nil
    respond_to do |format|
      if @idea.save
        format.html { redirect_to user_ideas_path, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        flash[:update_idea_success] = true
        format.html { redirect_to action: :edit }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @idea = Idea.find(params[:idea_id])
    if params[:status].to_i.zero?
      current_user.likes.where(idea_id: @idea.id).delete_all
    else
      like = current_user.likes.where(idea_id: @idea.id).first_or_create
      like.save
      if current_user.id != @idea.user.id
        noti = Notification.new(message: "#{current_user.fullname} liked your post", notification_type: 2, author: @idea.user.id, seen: false)
        noti.user = current_user
        noti.idea = @idea
        noti.save!
        @status = true
      end
    end
    #render 'user/ideas/_like', layout: false
    render 'user/ideas/like'
  end

  def like_comment
    @comment = Comment.find(params[:comment_id])
    if params[:status].to_i.zero?
      current_user.like_comments.where(comment_id: @comment.id).delete_all
    else
      like = current_user.like_comments.where(comment_id: @comment.id).first_or_create
      like.save!
      if current_user.id != @comment.user.id
        noti = Notification.new(message: "#{current_user.fullname} liked your comment", notification_type: 4, author: @comment.user.id, seen: false)
        noti.user = current_user
        noti.idea = @comment.idea
        noti.save!
        @status = true
      end
    end
    render 'user/ideas/like_comment'
  end

  def create_comment
    @comment = current_user.comments.build(idea_id: params[:idea_id], message: params[:message])
    @comment.save
    if current_user.id != @comment.idea.user.id
      noti = Notification.new(message: "#{current_user.fullname} commented on your post", notification_type: 1, author: @comment.idea.user.id, seen: false)
      noti.user = current_user
      noti.idea = @comment.idea
      noti.save!
    end
    #render 'user/ideas/_comment', layout: false
    render 'user/ideas/create'
  end

  def create_reply
    @root_comment = Comment.find(params[:comment_id])
    @comment = @root_comment.dup
    @comment.update_attributes(user_id: current_user.id, message: params[:message], parent_id: @root_comment.id)
    #render 'user/ideas/_reply', layout: false
    if current_user.id != @root_comment.user.id
      noti = Notification.new(message: "#{current_user.fullname} replied your comment", notification_type: 5, author: @root_comment.user.id, seen: false)
      noti.user = current_user
      noti.idea = @root_comment.idea
      noti.save!
      @status = true
    end
    render 'user/ideas/create_comment'
  end

  def update_comment
    comment = Comment.find(params[:comment_id])
    comment.update(message: params[:message])
    comment.save
    render json: comment.message
  end

  def create_replied_reply
    @root_comment = Comment.find(params[:reply_id])
    @comment = @root_comment.dup
    @comment.update_attributes(user_id: current_user.id, message: params[:message], parent_id: @root_comment.id)
    if current_user.id != @root_comment.user.id
      noti = Notification.new(message: "#{current_user.fullname} replied your reply", notification_type: 6, author: @root_comment.user.id, seen: false)
      noti.user = current_user
      noti.idea = @root_comment.idea
      noti.save!
      @status = true
    end
    render 'user/ideas/create_replied_reply'
  end

  def detailpage
    render 'users/detailpage'
  end

  def upcomingevent
    render 'users/upcomingevent'
  end

  def createvent
    render 'users/createvent'
  end

  def closeidea
    render 'users/closeidea'
  end

  def businessidea
    render 'users/businessidea'
  end

  def businessdetail
    render 'users/businessdetail'
  end

  def message
    @messages = Message.by_person(current_user)
    @groups = @messages.group_by(&:group_by_criteria).map {|k,v| [k, v.length]}.sort
    @groups = @groups.reverse
    if @groups.first.first.to_date == Date.today
      @today = Message.by_date(current_user, Date.today)
      @groups = @groups.drop(1)
    end

    # if @groups.first.first.to_date == Date.yesterday
    #   @yesterday = Message.by_date(current_user, Date.yesterday)
    #   @groups.drop(1)
  end

  def expand_messages
    @groups = Message.by_person(current_user).group_by(&:group_by_criteria).map {|k,v| [k, v.length]}.sort
    @groups = @groups.reverse.drop(2)
    @expand = true

    respond_to do |format|
      format.js
      format.html
    end
  end

  def reply_message
    @idea = Idea.find(params[:idea_id].to_i)
    @parent = Message.find(params[:message_id].to_i)
    @message = Message.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def my_ideas
    @ideas = search_ideas(params, user: current_user)
    render 'user/ideas/index'
  end

  def business_index
    @message = Message.new
    @identity = identity_form(current_user)
    @ideas = search_business_ideas(params)
    render 'user/ideas/business/index'
  end

  def load_more_business
    if params[:action_page] == 'my_ideas'
      @ideas = search_business_ideas(params, user: current_user)
    else
      @ideas = search_business_ideas(params)
    end
    render 'user/ideas/business/load_more_business', layout: false
  end

  def business_show
    @message = Message.new
    @favorite = current_user.favorites.where(idea_id: @idea.id).present?
    @deal = current_user.deals.where(idea_id: @idea.id).present?
    @idea.update_attributes(views: @idea.views + 1)
    @idea_type = find_business_idea_type(@idea.business_idea.business_idea_type)
    render 'user/ideas/business/show'
  end

  def business_new
    @order = Order.new
    @idea = Idea.new
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
    render 'user/ideas/business/new'
  end

  def business_create
    current_idea = Idea.by_name_status(idea_params[:title])
    @order = Order.new
    @value = current_user.profile_percentage
    # check if user click validate and save mutiple times
    if current_idea.present?
      Idea.destroy(current_idea)
    end
    if @value.first[:number] < 80
      redirect_to edit_user_registration_path
    else
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

      if @idea.save
        data = {idea_id: @idea.id}
        render :json => data, :status => :ok
      else
        data = {:message => "Alert this!"}
        render :json => data, :status => :error
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
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
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

  def authenticate_investor!
    redirect_to user_ideas_path unless current_user.investor?
  end

  def authenticate_investor_verified
    if current_user.investor?
      if !current_user.investor.verified?
        redirect_to business_user_ideas_path
      end
    else
      redirect_to business_user_ideas_path
    end
  end

  def search_ideas(params, user: nil)
    load_public_ideas(params, user)
  end

  def load_close_ideas
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(6) : nil
  end

end
