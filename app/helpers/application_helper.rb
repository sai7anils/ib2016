module ApplicationHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  def paginate objects, options = {}
    options.reverse_merge!( theme: 'twitter-bootstrap' )
    super( objects, options )
  end

  def get_profile(user)
    if !user.nil?
      if user.entrepreneur?
        url_helpers.entrepreneur_path(user)
      elsif user.investor?
        url_helpers.investor_path(user)
      elsif user.startup?
        url_helpers.startup_path(user)
      end
    end
  end

  def validate_date(date)
    begin
       Date.parse(date)
    rescue ArgumentError
       # handle invalid date
    end
  end

  def valid_url?(url)
    URI.parse(url)
  rescue URI::InvalidURIError
    false
  end

  def access_url(valid, idea)
    if valid
      url_helpers.user_business_idea_path(idea)
    else
      url_helpers.identities_new_user_investors_path
    end
  end

  def setting_id
    if IdeaBurn.all.count.zero?
      IdeaBurn.create!({
        name: 'IdeaBurns',
        seo_title: 'IdeaBurns - Global Online Startup Ecosystem Platform',
        video: 'http://www.youtube.com/v/ZeStnz5c2GI?fs=1&amp;autoplay=1',
        mail_from_address: 'services@ideaburns.com'
      })
    end
    IdeaBurn.last.id
  end

  def iterable?(object)
    if object.respond_to? :each
      object.next
    else
      object
    end
  end

  def get_header_data(user, type)
    case type
    when 'startup'
      user.by_confirmed.startup
    when 'investor'
      user.by_confirmed.investor
    when 'entrepreneur'
      user.by_confirmed.entrepreneur
    end
  end
end
