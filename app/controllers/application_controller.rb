class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_users, :set_data_footer
  after_filter :session_location
  before_action :set_locale

  private

  def session_location
    if (controller_name == "entrepreneurs" && action_name == "index")
      session[:previous_url] = request.fullpath
    end
  end

  def load_users
    @users = User.by_confirmed.order('created_at desc').page(params[:page]).per(8)
  end

  def set_data_footer
    @data_footer = IdeaBurn.first
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
