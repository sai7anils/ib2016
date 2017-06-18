module Frontend
  def business_percentage
    @is_nil = 0
    @total = 0
    param_is_nil(only_idea_business_params)
    param_is_nil(only_idea_business_exit_params)
    param_is_nil(only_idea_business_custom_params)
    param_is_nil(only_idea_business_investment_params)
    param_is_nil(only_idea_business_market_params)
    param_is_nil(business_potencial_params)
    param_is_nil(only_idea_business_pitch_params)
    param_is_nil(competitor_params)
    param_is_nil(team_cappabilitie_params)
    percent = (@total - @is_nil).to_f / @total.to_f
    percent*100
  end

  def param_is_nil(parent)
    parent.each do |param|
      @total = @total + 1
      if param[1].nil? || param[1] == ""
        @is_nil = @is_nil + 1
      end
    end
  end

  def load_business_ideas(params, user)
    ideas = Idea.by_closed
    ideas = User.find(user).ideas.by_closed unless user.nil?
    ideas = ideas.by_business_line(params[:business_line]) if params[:business_line].present?
    ideas = ideas.by_idea_stage(params[:idea_stage]) if params[:idea_stage].present?
    ideas = ideas.by_patent(params[:patent]) if params[:patent].present?
    if params[:location].present? && params[:location].length > 0
      ideas = ideas.by_business_location(params[:location])
      ideas = Kaminari.paginate_array(ideas).page(params[:page]).per(20)
    else
      ideas = ideas.page(params[:page]).order('created_at desc').per(20)
    end
    ideas
  end

  def load_public_ideas(params, user)
    ideas = Idea.by_public
    ideas = User.find(user).ideas.by_public unless user.nil?
    ideas = ideas.by_keyword(params[:q]) if params[:q].present?
    ideas = ideas.by_category(params[:c]) if params[:c].present?
    ideas = ideas.by_country(params[:country])if params[:country].present?
    ideas = ideas.page(params[:page]).order('created_at desc').per(20)
  end

  def investor_favourites(params, user)
    if user.investor?
      ideas = Idea.by_closed
      ideas = ideas.by_business_line(params[:business_line]) if params[:business_line].present?
      ideas = ideas.by_idea_stage(params[:idea_stage]) if params[:idea_stage].present?
      ideas = ideas.by_patent(params[:patent]) if params[:patent].present?
      ideasArr = []
      if !user.favorites.count.zero?
        user.favorites.each do |favorite|
          if params[:location].present? && params[:location].length > 0
            idea = ideas.find(favorite.idea_id) rescue nil
            if !idea.nil? && !idea.business_idea.nil? && !idea.business_idea.customer_analysis.nil?
              if idea.business_idea.customer_analysis.region.include? params[:location]
                ideasArr << idea
              end
            end
          else
            ideasArr << ideas.find(favorite.idea_id) rescue nil
          end
        end
      end
      ideasArr = ideasArr.compact
    else
      redirect_to business_user_ideas_path
    end
  end

  def find_business_idea_type(id)
    BusinessIdeaType.find(id).name
  end
end
