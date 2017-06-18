class ChangeLocaleController < ApplicationController
  def change
    lang = params[:locale]
    I18n.locale = :"#{lang}"
    set_session_and_redirect
  end

  private
  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to :root
  end
end
