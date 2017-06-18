class User::SessionsController < Devise::SessionsController
  include ApplicationHelper
  before_filter :load_events, only: [:new]
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def after_sign_in_path_for(resource)
    if current_user.entrepreneur?
      session[:previous_url] || user_ideas_path
    elsif current_user.startup?
      session[:previous_url] || user_ideas_path
    elsif current_user.investor?
      session[:previous_url] || user_ideas_path
    elsif current_user.admin?
      session[:previous_url] || admin_root_path
    end
  end

  private

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
