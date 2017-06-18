class Api::IdeaController < ApplicationController
  before_action :get_idea, only: [:comments, :rating_page, :like_page, :likes, :intrested, :deal, :favorite]

  def comments
    @comments = @idea.comments.where(parent_id: nil).page(params[:limit]).order(id: :desc)
    render layout: false
  end

  def like_page
    render layout: false
  end

  def rating_page
    render layout: false
  end

  def likes
    render layout: false
  end

  def user_idea_liked
    @idea = Idea.find(params[:id])
    render layout: false
  end

  def intrested
    if !current_user.likes.where(idea_id: @idea.id).count.zero?
      like = current_user.likes.where(idea_id: @idea.id).first.delete
    else
      like = current_user.likes.where(idea_id: @idea.id).first_or_create
    end
    like.save
    render layout: false
  end

  def favorite
    if !current_user.favorites.by_idea(@idea.id).count.zero?
      favorite = current_user.favorites.by_idea(@idea.id).first.delete
      @favorite = false
    else
      favorite = current_user.favorites.by_idea(@idea.id).first_or_create
      @favorite = true
    end
    favorite.save
    render layout: false
  end

  def deal
    if !current_user.deals.by_idea(@idea.id).count.zero?
      deal = current_user.deals.by_idea(@idea.id).first.delete
      @deal = false
    else
      deal = current_user.deals.by_idea(@idea.id).first_or_create
      @deal = true
    end
    deal.save
    render layout: false
  end

  private

  def get_idea
    @idea = Idea.find(params[:id])
  end

end
