class Admin::AjaxController < Admin::ApplicationController
  include Admin::User
  before_action :load_user, only: [:delete_user]

  def delete_user
    render json: access_delete?(@user)
  end

  private
  def load_user
    @user = User.find(params[:id])
  end
end
