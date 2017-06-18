module Admin
  module User
    def switch_to_user(user)
      if user.entrepreneur?
        user.build_entrepreneur if user.entrepreneur.nil?
      elsif user.startup?
        user.build_startup if user.startup.nil?
      elsif user.investor?
        user.build_investor if user.investor.nil?
        @business_lines = user.investor.business_line.present? ? user.investor.business_line : nil
        @investor_type = user.investor.investor_type
      elsif user.admin?

      end
      user
    end

    def load_edit_template(user)
      "admin/user/update"
    end

    def access_delete?(user)
      return false unless current_user.admin? # return if current user is not admin
      return false if user && user.admin? # return if user to delete is admin
      user.destroy
      true
    end

    def email_valid?(email)
      output = false
      if email =~ /\A[^@]+@[^@]+\Z/
        output = true
      end
      output
    end
  end

  module AdminIdea
    def load_public_ideas(params)
      ideas = Idea.by_public
      ideas = ideas.by_keyword(params[:search]) if !params[:search].blank? && !ideas.category?(params[:search])
      ideas = ideas.by_category_name(params[:search]) if !params[:search].blank? && ideas.category?(params[:search])
      ideas = ideas.kind_of?(Array) ? Kaminari.paginate_array(ideas).page(params[:page]).per(20) : ideas.page(params[:page]).order('created_at desc').per(20)
    end
  end

  module AdminEvent
    def load_events(params)
      events = Event.all
      events = events.by_keyword(params[:keyword]) if params[:keyword].present?
      events = events.by_country(params[:country]) if params[:country].present?
      events = events.by_category(params[:category]) if params[:category].present?
      events = events.by_date(validate_date(params[:date])) if params[:date].present?
      events = events.page(params[:page]).order('event_from desc').per(10)
    end
  end
end
