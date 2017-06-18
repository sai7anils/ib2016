class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter do
    redirect_to new_user_session_path unless current_user.admin?
  end
  layout 'admin'

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_root_path
    else
      root_path
    end
  end
end