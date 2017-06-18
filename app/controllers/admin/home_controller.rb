class Admin::HomeController < Admin::ApplicationController
  include ActionView::Helpers::NumberHelper
  def index
    @data = {
      users: User.by_confirmed.count,
      comments: Comment.all.count,
      ideas: Idea.all.count,
      idea_views: number_to_human(Idea.sum(:views), :format => '%n%u', :units => { :thousand => 'K', :million => 'M'})
    }
  end
end
