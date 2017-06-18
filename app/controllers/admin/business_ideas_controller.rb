class Admin::BusinessIdeasController < Admin::ApplicationController
  before_action :set_business_idea, only: [:show, :destroy]

  def index
    @business_ideas = BusinessIdea.search_by_keyword(params[:keyword]).page(params[:page])
  end

  def show
  end

  def destroy
    @business_idea.destroy
    respond_to do |format|
      format.json { render json: true }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_idea
      @business_idea = BusinessIdea.find(params[:id])
    end
end
