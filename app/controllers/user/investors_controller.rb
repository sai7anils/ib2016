class User::InvestorsController < ApplicationController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Identity
  include Frontend
  layout :layout_by_action

  before_action :authenticate_user!, only: [:show, :identity_new, :identity_create, :message_new, :message_create, :my_favourites]
  before_action :load_close_ideas
  before_action :authenticate_admin!, only: [:confirm_email]

  def index
    @users = search_investers(params)
  end

   def load_more
    @users = search_investers(params)
    render layout:false
  end

  def show
    @user = User.find(params[:id])
    @info = @user.investor
  end

  #Create identities of investor
  # GET /ideas/new

  def identity_new
    @identity = identity_form(current_user)
  end

  # POST /ideas
  # POST /ideas.json
  def identity_create
    if current_user.investor.nil?
      current_user.build_investor
    end
    @identity = current_user.investor.create_investor_identity(identity_params)
    @identity.investor.confirmation_token
    if @identity.investor.save
      respond_to do |format|
        if @identity.save
          IdentityMailer.identity_confirmation(@identity.investor.user).deliver
          format.html { redirect_to user_business_ideas_path, notice: 'We’ve received your documents. We will get back to 24-72 hours to activate your account.' }
          format.json { render :show, status: :created, location: @identity }
        else
          format.html { render :new, template: 'user/investors/identity_new' }
          format.json { render json: @identity.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  def message_new
    @message = Message.new

  end
  # POST /ideas
  # POST /ideas.json
  def message_create
    if current_user.investor.nil?
      current_user.build_investor
    end
    @message = Message.create(message_params)
    @message.sender_id = current_user.id
    if @message.save
      @status = true
    else
      @status = false
    end
    render 'user/investors/message_create'
  end

  def confirm_email
    investor = Investor.find_by_confirm_token(params[:id])
    if investor.present?
      investor.email_activate
      flash[:notice] = "Success!"
      redirect_to business_user_ideas_path
    else
      flash[:notice] = "User unknown!"
      redirect_to business_user_ideas_path
    end
  end

  def my_favourites
    @identity = identity_form(current_user)
    @ideas = search_business_ideas(params)
    render 'user/business_ideas/index'
  end

  def load_more_business
    @ideas = search_business_ideas(params)
    render 'user/ideas/business/load_more_business', layout: false
  end

  def load_more
    @users = search_investers(params)
    render layout:false
  end

  private
  def message_params
    params.require(:message).permit(:detail, :receiver_id, :idea_id)
  end

  def identity_params
    params.require(:investor_identity).permit(:investor_id, :indentity_proof, :nationality_identity_proof, :unique_identity_document, attachments_attributes: [:id , :file])
  end

  def search_investers(params)
    users = User.by_confirmed.joins(:investor)
    users = Investor.by_investor_type(users,params[:investor_type]) if params[:investor_type].present?
    users = users.by_country(params[:country]) if params[:country].present?
    # name = BusinessLine.find(params[:business_line].to_i).name if params[:business_line].present?
    users = Investor.by_business_line(users, params[:business_line]) if params[:business_line].present?
    users =  Kaminari.paginate_array(users).page(params[:page]).per(20)
    return users
  end

  def layout_by_action
   action_name == 'show' ? 'user' : 'idea'
  end

  def load_close_ideas
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(6) : nil
  end

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user
  end

  def search_business_ideas(params)
    ideas = investor_favourites(params, current_user)
    ideas = Kaminari.paginate_array(ideas).page(params[:page]).per(20)
  end

end
