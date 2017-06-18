class Admin::UserController < Admin::ApplicationController
  include Admin::User
  before_action :load_user, only: [:edit, :update, :show]

  def index
    @users = User.search(params).order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit; end

  def update
    if @user.admin?
      if !update_pwd_params[:current_password].blank?
        if !update_pwd_params[:password].blank? && @user.update_with_password(update_pwd_params)
          flash[:update_success] = true
          redirect_to action: :edit
        else
          flash[:update_errors] = "Current password not match or errors with new password"
          render  "edit"
        end
      else
        flash[:update_errors] = "Current password can't be blank"
        render  "edit"
      end
    else
      if !normal_pwd_params[:password].blank? && @user.update_attributes(normal_pwd_params)
        flash[:update_success] = true
        redirect_to action: :edit
      else
        flash[:update_errors] = "Errors with new password"
        render  "edit"
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @user.update_attributes({confirmed_at: Time.now})
        format.html { redirect_to admin_user_index_path, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @role = @user.send(@user.user_type) unless @user.admin?
  end

  def entrepreneurs
    @entrepreneurs = Entrepreneur.search(params).page(params[:page]).per(20)
  end

  def investors
    @investors = Investor.search(params).page(params[:page]).per(20)
  end

  def startups
    @startups = Startup.search(params).page(params[:page]).per(20)
  end

  private

  def load_user
    user = User.find(params[:id])
    @user = switch_to_user(user)
    @template = load_edit_template(@user)
  end

  def update_pwd_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :reset_password_token)
  end

  def normal_pwd_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:user_type, :username, :email, :password, :password_confirmation)
  end

end
