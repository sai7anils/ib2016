class Admin::IdeasController < Admin::ApplicationController
  include Admin::User
  include Admin::AdminIdea
  before_action :load_idea, only: [:edit, :update, :destroy]

  def index
    @ideas = search_public_ideas(params)
  end

  def new
    @idea = Idea.new
  end

  def edit; end

  def show; end

  def create
    @idea = Idea.new(ideas_params)
    respond_to do |format|
      if @idea.save
        format.html { redirect_to admin_ideas_path, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @idea.update(ideas_params)
        format.html { redirect_to edit_admin_idea_path(@idea), notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @idea.destroy
    respond_to do |format|
      format.json { render json: true}
    end
  end

  private

  def search_public_ideas(params)
    load_public_ideas(params)
  end

  def load_idea
    @idea = Idea.find(params[:id])
    @user = switch_to_user(current_user)
    @template =  load_edit_template(@user)
  end

  def ideas_params
    params.require(:idea).permit( :category_id, :title, :description, :attachment)
  end
end
