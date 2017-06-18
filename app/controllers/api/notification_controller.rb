class Api::NotificationController < ApplicationController
  def index
     @notifications =  Notification.by_user_id(current_user.id).page(params[:page]).per(6)
     render layout: false
  end

  def seen
    Notification.seen_by_user_id(current_user.id)
    render json: true
  end

  def loadmore
     @notifications =  Notification.by_user_id(current_user.id).page(params[:page]).per(6)
     render layout: false
  end
end
