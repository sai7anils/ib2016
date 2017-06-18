class User::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :load_events, only: [:new]
  layout :layout_by_action

  # GET /resource/sign_up
   def new
     super
     @user = User.new
   end

  # POST /resource
  #def create
  #  super
  #end

  # GET /resource/edit
  def edit
    if current_user.entrepreneur?
      current_user.build_entrepreneur if current_user.entrepreneur.nil?
    elsif current_user.startup?
      current_user.build_startup if current_user.startup.nil?
    elsif current_user.investor?
      current_user.build_investor if current_user.investor.nil?
      @business_lines = current_user.investor.business_line
      @investor_type = current_user.investor.investor_type
    elsif current_user.admin?
      redirect_to admin_root_path
    end
  end

  # PUT /resource
  def update
    super
    if current_user.present?
      if current_user.entrepreneur?
        entrepreneur_update_params = params[:user][:entrepreneur_attributes].permit(:first_name, :last_name, :dob, :gender, :profession_type, :profession_company, :profession_skill, :profession_experience, :graduation, :university, :mobile, :address, :website, :email_second, :about, :inspire_quote, :linkedin, :skype )
        entrepreneur = Entrepreneur.new(entrepreneur_update_params)
        current_user.entrepreneur = entrepreneur
      elsif current_user.startup?
        startup_update_params = params[:user][:startup_attributes].permit(:name, :founded, :category, :website, :strength, :mission, :work, :register_under, :reg_company_name, :facebook, :twitter, :linkedin, :ios_app, :adroid_app, :window_app, :address_line_1, :address_line_2, :funding_type, :funding_amout, :funding_date, :funding_by_investor, :about, teams_attributes: [:id, :name, :designation, :joined_date, :email, :mobile, :linkedin, :skype, :image, :_destroy], fundings_attributes: [:id, :funding_type, :amount, :date, :by_investor, :_destroy])

        if current_user.startup.nil?
          current_user.startup = Startup.new(startup_update_params)
        elsif
          if current_user.startup.teams.nil?
            current_user.startup = Startup.new(startup_update_params)
          else
            current_user.startup.update_attributes(startup_update_params)
          end
        end
      elsif current_user.investor?
        investor_update_params = params[:user][:investor_attributes].permit(:name, :founded, :category, :website, :mission, :work, :register_under, :description, :address_line_1, :address_line_2, :facebook, :twitter, :linkedin, :ios_app, :adroid_app, :windows_app, :investor_type, {:business_line => []}, :linkedin, :first_name, :last_name, :gender, :dob, :website_secondary, :skype, investor_teams_attributes: [:id, :name, :designation, :joined_date, :email, :mobile, :linkedin, :skype, :image, :_destroy], portfolios_attributes: [:id, :name, :website, :fundding_type, :amount, :logo, :_destroy])
          current_user.investor.update_attributes(investor_update_params)
      end
      current_user.save!
    end
    flash[:update_success] = true
  end

  def edit_password
    @user = User.find(current_user.id)
  end

  def update_password
    @user = User.find(current_user.id)
    if !update_pwd_params[:password].blank? && @user.update_with_password(update_pwd_params)
      sign_in @user, :bypass => true
      flash[:update_success] = true
      redirect_to action: :edit_password
    else
      if update_pwd_params[:password].blank?
        flash[:update_errors] = true
      else
        flash[:update_errors] = false
      end
      render "edit_password"
    end
  end
  def loadmorenotification
    pageno = params[:pageno].to_i
    search = params[:search].to_s
    if search.present?
      @notifications = Notification.search(current_user.id, params[:search]).page(params[:pageno]).per(6)
    else
      @notifications = Notification.by_user_id(current_user.id).page(params[:pageno]).per(6)
    end
    render 'user/registrations/_loadmorenotification', layout: false
  end
  def notification
    @search = params[:search].to_s
    if @search.present?
      @notifications = Notification.search(current_user.id, params[:search]).page(params[:page]).per(6)
    else
      @notifications = Notification.by_user_id(current_user.id).page(params[:page]).per(6)
    end

    @count_notification = Notification.by_user_id(current_user.id).count
    @notifications_unread_count = Notification.unread_by_user_id(current_user.id).count
    @closed_ideas = Idea.by_closed.present? ? Idea.by_closed.sample(5) : nil
    respond_to do |format|
      format.html
      format.js
    end
  end
  def message
    respond_to do |format|
      format.html
      format.js
    end
  end
  def unread
    respond_to do |format|
      format.html
      format.js
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.for(:sign_up) << [:user_type, :username]
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    #devise_parameter_sanitizer.for(:account_update) << [:county, :city, :home_town]
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:country, :city, :region, :photo, entrepreneur_attributes: [:first_name, :last_name])
    end
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
   super(resource)
   edit_user_registration_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  private

  def layout_by_action
    actions = ['edit', 'update', 'edit_password', 'update_password', 'notification']
    if actions.include? action_name
      "user"
    else
      "application"
    end
  end

  def startup_params
    params[:user][:startup].permit(:name, :founded, :category, :website, :strength, :mission, :work, :register_under)
  end

  def entrepreneur_params
    params[:user][:entrepreneur].permit(:first_name, :last_name, :age, :dob, :gender, :entrepreneur_type)
  end

  def investor_params
    params[:user][:investor].permit(:name, :founded, :category, :website, :mission, :work, :register_under)
  end

  def update_pwd_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
     edit_user_registration_path
  end

  def load_events
    @events = search_events(params)
  end

  def search_events(params)
    events = Event.all
    events = events.by_keyword(params[:keyword]) if params[:keyword].present?
    events = events.by_country(params[:country])if params[:country].present?
    events = events.by_date(validate_date(params[:date])) if params[:date].present?
    events = events.page(params[:page]).order('event_from desc').per(5)
  end

end
