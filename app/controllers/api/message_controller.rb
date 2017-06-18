class Api::MessageController < ApplicationController
  def index
     @message =  Message.by_person(current_user).page(params[:page]).per(6)
     render layout: false
  end

  def seen
    Message.seen_by_user_id(current_user.id)
    render json: true
  end

  def loadmore
     @message =  Message.by_person(current_user).page(params[:page]).per(10)
     render layout: false
  end
end
